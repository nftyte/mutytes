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

let mutytes, initFacet, owner, accs, availableSupply;

const initialSupply = 1000;

describe("ERC721Mintable Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("MutytesAPI").at(mutytesProxy.address);
        initFacet = await deployable("MutytesInitFacet").at(mutytes.address);
        initBalances([owner, ...accs]);
        mutytes.on("Transfer", onTransfer);
    });

    it("should prevent mint > supply", async () => {
        await expect(mutytes.mint(1)).to.be.revertedWith("OutOfBounds");
    });

    it("should init supply", async () => {
        await expect(
            initFacet.connect(accs[0]).initSupply(initialSupply)
        ).to.be.revertedWith("UnexpectedAddress");
        await initFacet.initSupply((availableSupply = initialSupply));
        assert.equal(await mutytes.availableSupply(), initialSupply);
    });

    it("should mint tokens", async () => {
        const amount = 2;
        await mutytes.mint(amount);
        await onUpdateBalanceOf(owner, amount);
        assert.equal(await mutytes.balanceOf(owner.address), balanceOf(owner));
        assert.equal(await mutytes.availableSupply(), (availableSupply -= amount));
    });

    it("should mint more tokens", async () => {
        const amount = 2;
        await mutytes.mint(amount);
        await onUpdateBalanceOf(owner, amount);
        assert.equal(await mutytes.balanceOf(owner.address), balanceOf(owner));
        assert.equal(await mutytes.availableSupply(), (availableSupply -= amount));
        assert.equal(tokensOf(owner)[1].add(1).toString(), tokensOf(owner)[2].toString());
    });

    it("should burn and mint more tokens", async () => {
        const amount = 1;
        await mutytes.burn(tokensOf(owner)[3]);
        await onUpdateBalanceOf(owner, -1);
        await mutytes.mint(amount);
        await onUpdateBalanceOf(owner, amount);
        assert.equal(await mutytes.balanceOf(owner.address), balanceOf(owner));
        assert.equal(await mutytes.availableSupply(), (availableSupply -= amount));
        assert.equal(tokensOf(owner)[2].add(2).toString(), tokensOf(owner)[3].toString());
    });

    it("shouldn't mint if balance > 10", async () => {
        await expect(mutytes.mint(6)).to.be.revertedWith("OutOfBounds");
    });

    it("shouldn't mint if tx value > 0", async () => {
        await expect(
            mutytes.mint(1, { value: ethers.utils.parseEther((0.1).toFixed(2)) })
        ).to.be.revertedWith("NonZero");
    });
});
