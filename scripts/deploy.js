const { deployable } = require("./libraries/deployable");
const { selectorCollection, FacetCutAction } = require("./libraries/selectors");

async function deploy() {
    const diamond = await deployable("MutytesDiamondFacet").deploy();
    console.log("MutytesDiamondFacet deployed:", diamond.address);

    const mutytes = await deployable("MutytesProxy").deploy(
        diamond.address,
        diamond.interface.encodeFunctionData("init(address)", [diamond.address])
    );
    console.log("Mutytes deployed:", mutytes.address);

    const init = await deployable("MutytesInitFacet").deploy();
    console.log("MutytesInitFacet deployed:", init.address);

    const diamondFacet = await deployable("MutytesDiamondFacet").at(mutytes.address);
    const mutytesSelectors = selectorCollection(mutytes).removeFunctions(
        ...selectorCollection(await deployable("ERC721Enumerable").contract()).functions
    ).selectors;
    const cuts = [
        {
            facetAddress: mutytes.address,
            action: FacetCutAction.Add,
            functionSelectors: mutytesSelectors,
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
        ["ERC165", "Ownable", "ERC721", "ERC721Metadata", "DiamondReadable"].map(
            async (c) => selectorCollection(await deployable(c).contract()).interfaceId
        )
    );
    const setFunctionsAndInterfacesCall = init.interface.encodeFunctionData(
        "setFunctionsAndInterfaces(bytes4[],bool,bytes4[],bool)",
        [mutytesSelectors, true, supportedInterfaces, true]
    );

    await diamondFacet.diamondCut(cuts, init.address, setFunctionsAndInterfacesCall, {
        gasLimit: 1500000,
    });
    console.log("Completed diamond cut");

    return mutytes;
}

if (require.main === module) {
    deploy()
        .then(() => process.exit(0))
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });
}

exports.deploy = deploy;
