const FacetCutAction = { Add: 0, Replace: 1, Remove: 2 };

let facet;

function diamond(diamondFacet) {
    facet = diamondFacet;

    return { addFunctions, removeFunctions };
}

function addFunctions(facetAddress, functionSelectors) {
    const cuts = [
        {
            facetAddress,
            action: FacetCutAction.Add,
            functionSelectors,
        },
    ];

    return facet.diamondCut(cuts, ethers.constants.AddressZero, "0x");
}

function removeFunctions(functionSelectors) {
    const cuts = [
        {
            facetAddress: ethers.constants.AddressZero,
            action: FacetCutAction.Remove,
            functionSelectors,
        },
    ];

    return facet.diamondCut(cuts, ethers.constants.AddressZero, "0x");
}

exports.FacetCutAction = FacetCutAction;
exports.diamond = diamond;
exports.addFunctions = addFunctions;
exports.removeFunctions = removeFunctions;
