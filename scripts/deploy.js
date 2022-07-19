const { deployable } = require("./libraries/deployable");
const { FacetCutAction } = require("./libraries/diamond");
const { selectorCollection } = require("./libraries/selectors");

async function deploy(verbose = false) {
    const interpreter = await deployInterpreter();
    if (verbose) console.log("MutyteInterpreter deployed:", interpreter.address);

    const legacyAdapter = await deployable("MutytesLegacyProvider").deploy(
        interpreter.address,
        "https://www.mutytes.com/mutyte/"
    );
    if (verbose) console.log("MutytesLegacyProvider deployed:", legacyAdapter.address);

    const diamond = await deployable("MutytesDiamondFacet").deploy();
    if (verbose) console.log("MutytesDiamondFacet deployed:", diamond.address);

    const mutytes = await deployable("Mutytes").deploy(
        diamond.address,
        diamond.interface.encodeFunctionData("init(address)", [diamond.address])
    );
    if (verbose) console.log("Mutytes deployed:", mutytes.address);

    const init = await deployable("MutytesInitFacet").deploy();
    if (verbose) console.log("MutytesInitFacet deployed:", init.address);

    const diamondFacet = await deployable("MutytesDiamondFacet").at(mutytes.address);
    const initFacet = await deployable("MutytesInitFacet").at(mutytes.address);
    const mutytesSelectors = selectorCollection(mutytes).removeFunctions(
        "tokenByIndex(uint256)",
        "tokenOfOwnerByIndex(address,uint256)",
        "supportsInterface(bytes4)"
    );
    const cuts = [
        {
            facetAddress: mutytes.address,
            action: FacetCutAction.Add,
            functionSelectors: mutytesSelectors.selectors,
        },
        {
            facetAddress: diamond.address,
            action: FacetCutAction.Add,
            functionSelectors: selectorCollection(
                await deployable("DiamondReadable").contract()
            ).selectors,
        },
        {
            facetAddress: init.address,
            action: FacetCutAction.Add,
            functionSelectors: selectorCollection(init).selectors,
        },
    ];
    const supportedInterfaces = await Promise.all(
        ["Ownable", "ERC721Metadata", "DiamondReadable"].map(
            async (c) => selectorCollection(await deployable(c).contract()).interfaceId
        )
    );
    const setFunctionsAndInterfacesCall = init.interface.encodeFunctionData(
        "setFunctionsAndInterfaces(bytes4[],bool,bytes4[],bool)",
        [
            mutytesSelectors.addFunctions("supportsInterface(bytes4)").selectors,
            true,
            supportedInterfaces,
            true,
        ]
    );

    await diamondFacet.diamondCut(cuts, init.address, setFunctionsAndInterfacesCall, {
        gasLimit: 1500000,
    });
    if (verbose) console.log("Completed diamond cut");

    await initFacet.initTokenURI(0, legacyAdapter.address, false, { gasLimit: 100000 });
    if (verbose) console.log("Initialized token URI");

    return mutytes;
}

async function deployInterpreter() {
    const models = await deployable("Models").deploy();
    const Interpreter = await ethers.getContractFactory("MutyteInterpreter", {
        libraries: { Models: models.address },
    });
    const interpreter = await Interpreter.deploy();
    await interpreter.deployed();
    return interpreter;
}

if (require.main === module) {
    deploy(true)
        .then(() => process.exit(0))
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });
}

exports.deploy = deploy;
