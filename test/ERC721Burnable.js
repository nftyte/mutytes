const {
    tokensOf,
    balanceOf,
    initBalances,
    onUpdateBalanceOf,
    onTransfer,
} = require("../scripts/libraries/balances");
const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");

const { assert, expect } = require("chai");

let mutytes, owner, accs, availableSupply;

const initialSupply = 1000;

describe("ERC721Burnable Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("Mutytes").at(mutytesProxy.address);
        const initFacet = await deployable("MutytesInitFacet").at(mutytes.address);
        initBalances([owner, ...accs]);
        mutytes.on("Transfer", onTransfer);
        await initFacet.initSupply(initialSupply);
        await mutytes.mint(4);
        await onUpdateBalanceOf(owner, 4);
        availableSupply = initialSupply - 4;
    });

    it("should burn tokens", async () => {
        let tokens = [...tokensOf(owner)];
        await mutytes.burn(tokens[0]);
        await onUpdateBalanceOf(owner, -1);
        assert.equal(await mutytes.balanceOf(owner.address), balanceOf(owner));
        await expect(mutytes.ownerOf(tokens[0])).to.be.revertedWith("ZeroAddress");
        await expect(mutytes.burn(tokens[0])).to.be.revertedWith("Unapproved");
    });
});
