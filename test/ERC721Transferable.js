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
const { BigNumber } = require("ethers");

let mutytes, owner, accs, availableSupply;

const initialSupply = 1000;

describe("ERC721Transferable Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("MutytesAPI").at(mutytesProxy.address);
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

    it("should transfer tokens", async () => {
        const to = accs[1];
        await mutytes.transferFrom(owner.address, to.address, tokensOf(owner)[0]);
        await onUpdateBalanceOf(to, 1);
        assert.equal(await mutytes.balanceOf(to.address), balanceOf(to));
        assert.equal(await mutytes.balanceOf(owner.address), balanceOf(owner));
        assert.equal(await mutytes.ownerOf(tokensOf(to)[0]), to.address);
    });

    it("should transfer more tokens", async () => {
        const from = accs[1];
        const to = accs[2];
        await mutytes
            .connect(from)
            .transferFrom(from.address, to.address, tokensOf(from)[0]);
        await onUpdateBalanceOf(to, 1);
        assert.equal(await mutytes.balanceOf(to.address), balanceOf(to));
        assert.equal(await mutytes.balanceOf(from.address), balanceOf(from));
        assert.equal(await mutytes.ownerOf(tokensOf(to)[0]), to.address);
    });

    it("should transfer only if approved", async () => {
        const to = accs[1];
        let tokenId = tokensOf(owner)[0];
        await expect(
            mutytes.connect(to).transferFrom(owner.address, to.address, tokenId)
        ).to.be.revertedWith("Unapproved");
        await mutytes.approve(to.address, tokenId);
        await mutytes.connect(to).transferFrom(owner.address, to.address, tokenId);
        await onUpdateBalanceOf(to, 1);
        assert.equal(await mutytes.ownerOf(tokenId), to.address);
        assert.equal(await mutytes.getApproved(tokenId), ethers.constants.AddressZero);
        tokenId = tokensOf(owner)[0];
        await mutytes.setApprovalForAll(to.address, true);
        await mutytes.connect(to).transferFrom(owner.address, to.address, tokenId);
        await onUpdateBalanceOf(to, 1);
        assert.equal(await mutytes.ownerOf(tokenId), to.address);
    });

    it("shouldn't transfer to zero address", async () => {
        await expect(
            mutytes.transferFrom(
                owner.address,
                ethers.constants.AddressZero,
                tokensOf(owner)[0]
            )
        ).to.be.revertedWith("ZeroAddress");
    });

    it("shouldn't transfer from zero address", async () => {
        await expect(
            mutytes.transferFrom(
                ethers.constants.AddressZero,
                accs[1].address,
                tokensOf(owner)[0]
            )
        ).to.be.revertedWith("UnexpectedAddress");
    });

    it("shouldn't transfer non-existent tokens", async () => {
        await expect(
            mutytes.transferFrom(
                ethers.constants.AddressZero,
                accs[1].address,
                BigNumber.from(1)
            )
        ).to.be.revertedWith("Unapproved");
    });
});
