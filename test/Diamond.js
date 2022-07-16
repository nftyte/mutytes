const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");

const { assert } = require("chai");
const { ethers } = require("hardhat");

let mutytes, initFacet, diamondFacet;

const addresses = [];

describe("Diamond Test", async () => {
    before(async () => {
        const mutytesProxy = await deploy();
        mutytes = await deployable("Mutytes").at(mutytesProxy.address);
        initFacet = await deployable("MutytesInitFacet").at(mutytes.address);
        diamondFacet = await deployable("MutytesDiamondFacet").at(mutytes.address);
    });

    it("should have 3 facets", async () => {
        for (const address of await diamondFacet.facetAddresses()) {
            addresses.push(address);
        }
        assert.equal(addresses.length, 3);
    });
});
