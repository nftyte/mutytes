const {
    tokensOf,
    initBalances,
    onUpdateBalanceOf,
    onTransfer,
} = require("../scripts/libraries/balances");
const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");

const { assert, expect } = require("chai");
const { selectorCollection } = require("../scripts/libraries/selectors");
const { FacetCutAction } = require("../scripts/libraries/diamond");

let mutytes,
    initFacet,
    diamondFacet,
    owner,
    accs,
    availableSupply,
    tokens = [];

const initialSupply = 1000;

describe("ERC721Enumerable Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("MutytesAPI").at(mutytesProxy.address);
        initFacet = await deployable("MutytesInitFacet").at(mutytes.address);
        diamondFacet = await deployable("MutytesDiamondFacet").at(mutytes.address);
        initBalances([owner, ...accs]);
        mutytes.on("Transfer", onTransfer);
        await initFacet.initSupply(initialSupply, 0);
        availableSupply = initialSupply;

        for (let mint of [
            { acc: owner, amount: 3 },
            { acc: accs[0], amount: 4 },
            { acc: owner, amount: 2 },
            { acc: accs[1], amount: 4 },
        ]) {
            await mutytes.connect(mint.acc).mint(mint.amount);
            await onUpdateBalanceOf(mint.acc, mint.amount);
            tokens.push(...tokensOf(mint.acc).slice(-mint.amount));
            availableSupply -= mint.amount;
        }
    });

    it("should init enumerable extension", async () => {
        const p1 = await deployable("MutytesEnumerablePage1").deploy();
        const p2 = await deployable("MutytesEnumerablePage2").deploy();
        await initFacet.initEnumerable([
            { length: 7, pageAddress: p1.address },
            { length: 6, pageAddress: p2.address },
        ]);

        const enumerableInterface = selectorCollection(
            await deployable("ERC721Enumerable").contract()
        );
        const initFacetAddress = await diamondFacet.facetAddress(0x295776fb);
        const setFunctionsAndInterfacesCall = initFacet.interface.encodeFunctionData(
            "setFunctionsAndInterfaces(bytes4[],bool,bytes4[],bool)",
            [
                enumerableInterface.removeFunctions("totalSupply()").selectors,
                true,
                [enumerableInterface.interfaceId],
                true,
            ]
        );

        await diamondFacet.diamondCut(
            [
                {
                    facetAddress: mutytes.address,
                    action: FacetCutAction.Add,
                    functionSelectors: selectorCollection(
                        await deployable("ERC721Enumerable").contract()
                    ).removeFunctions("totalSupply()").selectors,
                },
            ],
            initFacetAddress,
            setFunctionsAndInterfacesCall
        );

        for (let i of enumerableInterface.selectors.map((s, i) => i)) {
            assert.equal(
                await diamondFacet.facetAddress(enumerableInterface.selectors[i]),
                mutytes.address
            );
        }

        assert.equal(
            await mutytes.supportsInterface(enumerableInterface.interfaceId),
            true
        );
    });

    it("test global enumeration", async () => {
        for (let [i, tid] of Object.entries(tokens)) {
            assert.equal(
                (await mutytes.tokenByIndex(parseInt(i))).toString(),
                tid.toString()
            );
        }
    });

    it("test owner enumeration", async () => {
        for (let acc of [owner, accs[0], accs[1]]) {
            for (let [i, tid] of Object.entries(tokensOf(acc))) {
                assert.equal(
                    (
                        await mutytes.tokenOfOwnerByIndex(acc.address, parseInt(i))
                    ).toString(),
                    tid.toString()
                );
            }
        }
    });

    it("should burn tokens and re-test", async () => {
        await mutytes.burn(tokensOf(owner)[1]);
        await onUpdateBalanceOf(owner, -1);
        tokens.splice(1, 1);
        await mutytes.connect(accs[0]).burn(tokensOf(accs[0])[1]);
        await onUpdateBalanceOf(accs[0], -1);
        tokens.splice(3, 1);

        for (let [i, tid] of Object.entries(tokens)) {
            assert.equal(
                (await mutytes.tokenByIndex(parseInt(i))).toString(),
                tid.toString()
            );
        }

        for (let acc of [owner, accs[0], accs[1]]) {
            for (let [i, tid] of Object.entries(tokensOf(acc))) {
                assert.equal(
                    (
                        await mutytes.tokenOfOwnerByIndex(acc.address, parseInt(i))
                    ).toString(),
                    tid.toString()
                );
            }
        }
    });

    it("shouldn't query global index > supply", async () => {
        await expect(mutytes.tokenByIndex(tokens.length)).to.be.revertedWith(
            "OutOfBounds"
        );
    });

    it("shouldn't query owner index > balance", async () => {
        for (let acc of [owner, accs[0], accs[1]]) {
            await expect(
                mutytes.tokenOfOwnerByIndex(acc.address, tokensOf(acc).length)
            ).to.be.revertedWith("OutOfBounds");
        }
    });
});
