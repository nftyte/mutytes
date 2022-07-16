const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");

const { assert, expect, use } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

let mutytes, owner, accs;

describe("SafeOwnable Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("Mutytes").at(mutytesProxy.address);
    });

    it("should be owned by owner account", async () => {
        assert.equal(await mutytes.owner(), owner.address);
    });

    it("should only let owner transfer ownership", async () => {
        await expect(
            mutytes.connect(accs[0]).transferOwnership(accs[0].address)
        ).to.be.revertedWith("UnexpectedAddress");
        await expect(mutytes.transferOwnership(accs[0].address)).to.not.be.reverted;
        assert.equal(await mutytes.nomineeOwner(), accs[0].address);
    });

    it("should be owned by owner account until nominee accepts", async () => {
        assert.equal(await mutytes.owner(), owner.address);
    });

    it("should let owner transfer ownership until nominee accepts", async () => {
        await expect(mutytes.transferOwnership(ethers.constants.AddressZero)).to.not.be
            .reverted;
        assert.equal(await mutytes.nomineeOwner(), ethers.constants.AddressZero);
        await expect(mutytes.transferOwnership(accs[0].address)).to.not.be.reverted;
        assert.equal(await mutytes.nomineeOwner(), accs[0].address);
    });

    it("should only let nominee owner accept ownership", async () => {
        await expect(mutytes.acceptOwnership()).to.be.revertedWith("UnexpectedAddress");
        await expect(mutytes.connect(accs[0]).acceptOwnership()).to.not.be.reverted;
        assert.equal(await mutytes.owner(), accs[0].address);
        assert.equal(await mutytes.nomineeOwner(), ethers.constants.AddressZero);
    });
});
