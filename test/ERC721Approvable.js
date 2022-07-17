const {
    tokensOf,
    initBalances,
    onUpdateBalanceOf,
    onTransfer,
} = require("../scripts/libraries/balances");
const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");

const { assert, expect } = require("chai");

let mutytes, owner, accs, availableSupply;

const initialSupply = 1000;

describe("ERC721Approvable Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("Mutytes").at(mutytesProxy.address);
        const initFacet = await deployable("MutytesInitFacet").at(mutytes.address);
        initBalances([owner, ...accs]);
        mutytes.on("Transfer", onTransfer);
        await initFacet.initSupply(initialSupply);
        await mutytes.mint(10);
        await onUpdateBalanceOf(owner, 10);
        await mutytes.connect(accs[0]).mint(10);
        await onUpdateBalanceOf(accs[0], 10);
        availableSupply = initialSupply - 20;
    });

    it("should approve tokens", async () => {
        const tokenId = tokensOf(owner)[0];
        const to = accs[1];
        await mutytes.approve(to.address, tokenId);
        assert.equal(await mutytes.getApproved(tokenId), to.address);
    });

    it("should approve operators", async () => {
        await mutytes.setApprovalForAll(accs[2].address, true);
        await mutytes.setApprovalForAll(accs[3].address, true);
        assert.equal(
            await mutytes.isApprovedForAll(owner.address, accs[2].address),
            true
        );
        assert.equal(
            await mutytes.isApprovedForAll(owner.address, accs[3].address),
            true
        );
    });

    it("should unapprove tokens", async () => {
        const tokenId = tokensOf(owner)[0];
        await mutytes.approve(ethers.constants.AddressZero, tokenId);
        assert.equal(await mutytes.getApproved(tokenId), ethers.constants.AddressZero);
    });

    it("should unapprove operators", async () => {
        await mutytes.setApprovalForAll(accs[3].address, false);
        assert.equal(
            await mutytes.isApprovedForAll(owner.address, accs[3].address),
            false
        );
    });

    it("shouldn't approve tokens to owner", async () => {
        await expect(
            mutytes.approve(owner.address, tokensOf(owner)[0])
        ).to.be.revertedWith("UnexpectedAddress");
    });

    it("shouldn't approve tokens if not owner or operator", async () => {
        const tokenId = tokensOf(owner)[0];
        const to = accs[3];
        await mutytes.approve(accs[1].address, tokenId);
        await expect(
            mutytes.connect(accs[1]).approve(to.address, tokenId)
        ).to.be.revertedWith("Unapproved");
        await mutytes.connect(accs[2]).approve(to.address, tokenId);
        assert.equal(await mutytes.getApproved(tokenId), to.address);
    });

    it("shouldn't approve zero-address operator", async () => {
        await expect(
            mutytes.setApprovalForAll(ethers.constants.AddressZero, true)
        ).to.be.revertedWith("ZeroAddress");
    });

    it("shouldn't approve owner as operator", async () => {
        await expect(mutytes.setApprovalForAll(owner.address, true)).to.be.revertedWith(
            "UnexpectedAddress"
        );
    });
});
