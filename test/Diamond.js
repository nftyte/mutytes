const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");

const { assert, expect } = require("chai");
const {
    FacetCutAction,
    diamond,
    addFunctions,
    removeFunctions,
} = require("../scripts/libraries/diamond");
const { selectorCollection } = require("../scripts/libraries/selectors");

let mutytes, mutytesInterface, initFacet, initFacetInterface, diamondFacet, owner, accs;

const addresses = [];

describe("Diamond Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("MutytesAPI").at(mutytesProxy.address);
        initFacet = await deployable("MutytesInitFacet").at(mutytes.address);
        diamondFacet = await deployable("MutytesDiamondFacet").at(mutytes.address);
        mutytesInterface = selectorCollection(mutytes).removeFunctions(
            "tokenByIndex(uint256)",
            "tokenOfOwnerByIndex(address,uint256)"
        );
        initFacetInterface = selectorCollection(initFacet);
    });

    it("should have 3 facets", async () => {
        for (const address of await diamondFacet.facetAddresses()) {
            addresses.push(address);
        }
        assert.equal(addresses.length, 3);
    });

    it("test if functions properly assigned", async () => {
        for (let facet of [
            { address: mutytes.address, interface: mutytesInterface },
            { address: addresses[2], interface: initFacetInterface },
            {
                address: addresses[0],
                interface:
                    selectorCollection(diamondFacet).removeFunctions("init(address)"),
            },
        ]) {
            const selectors = await diamondFacet.facetFunctionSelectors(facet.address);
            assert.sameMembers(selectors, facet.interface.selectors);

            for (let selector of facet.interface.selectors) {
                assert.equal(await diamondFacet.facetAddress(selector), facet.address);
            }
        }
    });

    it("should diamond cut only if owner", async () => {
        await expect(
            diamond(diamondFacet.connect(accs[0])).removeFunctions(
                mutytesInterface.selectors
            )
        ).to.be.revertedWith("UnexpectedAddress");
    });

    it("should remove some functions", async () => {
        await diamond(diamondFacet).removeFunctions(mutytesInterface.selectors);
        await expect(mutytes.availableSupply()).to.be.revertedWith("ZeroAddress");
        assert.equal((await diamondFacet.facetAddresses()).length, 2);
    });

    it("should add some functions", async () => {
        await addFunctions(mutytes.address, mutytesInterface.selectors);
        assert.equal((await diamondFacet.facetAddresses()).length, 3);
        await initFacet.initSupply(100);
        await initFacet.setUpgradableFunctions(mutytesInterface.selectors, true);
        assert.equal(await mutytes.availableSupply(), 100);
    });

    it("should upgrade some functions", async () => {
        const mintable = await deployable("ERC721Mintable").deploy();
        const erc721Base = await deployable("ERC721Base").deploy();
        const cuts = [
            {
                facetAddress: mintable.address,
                action: FacetCutAction.Replace,
                functionSelectors: selectorCollection(mintable).selectors,
            },
            {
                facetAddress: erc721Base.address,
                action: FacetCutAction.Replace,
                functionSelectors: selectorCollection(erc721Base).selectors,
            },
        ];
        await diamondFacet.diamondCut(cuts, ethers.constants.AddressZero, "0x");
        await mutytes.mint(11);
        assert.equal(await mutytes.balanceOf(owner.address), 11);
        assert.equal(await mutytes.availableSupply(), 89);
    });

    it("shouldn't add existing functions", async () => {
        await expect(
            addFunctions(mutytes.address, mutytesInterface.selectors)
        ).to.be.revertedWith("NonZeroAddress");
    });

    it("shouldn't remove non-existent functions", async () => {
        await expect(
            removeFunctions(
                selectorCollection(
                    await deployable("ERC721Enumerable").contract()
                ).removeFunctions("totalSupply()").selectors
            )
        ).to.be.revertedWith("ZeroAddress");
    });

    it("shouldn't remove immutable functions", async () => {
        await initFacet.setUpgradableFunctions(mutytesInterface.selectors, false);
        await expect(removeFunctions(mutytesInterface.selectors)).to.be.revertedWith(
            "UnexpectedAddress"
        );
        await initFacet.setUpgradableFunctions(mutytesInterface.selectors, true);
    });
});
