const { deploy } = require("../scripts/deploy");
const { deployable } = require("../scripts/libraries/deployable");
const { selectorCollection } = require("../scripts/libraries/selectors");

const { assert } = require("chai");

let mutytes;

describe("ERC165 Test", async () => {
    before(async () => {
        const mutytesProxy = await deploy();
        mutytes = await deployable("MutytesAPI").at(mutytesProxy.address);
    });

    for (let interfaceName of [
        "IERC165",
        "IERC173",
        "IERC721",
        "IERC721Metadata",
        "IDiamondReadable",
    ]) {
        it(`should support ${interfaceName}`, async () => {
            await assertSupportsInterface(interfaceName, true);
        });
    }

    it("shouldn't support IERC721Enumerable", async () => {
        await assertSupportsInterface("IERC721Enumerable", false);
    });
});

async function getInterfaceId(interfaceName) {
    return selectorCollection(await deployable(interfaceName).at(mutytes.address))
        .interfaceId;
}

async function assertSupportsInterface(interfaceName, isSupported) {
    assert.equal(
        await mutytes.supportsInterface(await getInterfaceId(interfaceName)),
        isSupported
    );
}
