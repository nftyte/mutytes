const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");

const { assert, expect } = require("chai");

let mutytes, owner, accs;

describe("SafeOwnable Test", async () => {
    before(async () => {
        [owner, ...accs] = await ethers.getSigners();
        const mutytesProxy = await deploy();
        mutytes = await deployable("Mutytes").at(mutytesProxy.address);
    });

    it("should transfer ownership only if owner", async () => {
        await expect(
            mutytes.connect(accs[0]).transferOwnership(accs[0].address)
        ).to.be.revertedWith("UnexpectedAddress");
        await mutytes.transferOwnership(accs[0].address);
        assert.equal(await mutytes.nomineeOwner(), accs[0].address);
    });

    it("should transfer ownership until ownership accepted", async () => {
        await mutytes.transferOwnership(ethers.constants.AddressZero);
        assert.equal(await mutytes.nomineeOwner(), ethers.constants.AddressZero);
        await mutytes.transferOwnership(accs[0].address);
        assert.equal(await mutytes.nomineeOwner(), accs[0].address);
    });

    it("should accept ownership only if nominee owner", async () => {
        await expect(mutytes.acceptOwnership()).to.be.revertedWith("UnexpectedAddress");
        await mutytes.connect(accs[0]).acceptOwnership();
        assert.equal(await mutytes.owner(), accs[0].address);
        assert.equal(await mutytes.nomineeOwner(), ethers.constants.AddressZero);
    });
});
