// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadable, IDiamondWritable } from "./IDiamond.sol";

abstract contract DiamondInit {
    function _IDiamond() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](5);
        selectors[0] = IDiamondReadable.facets.selector;
        selectors[1] = IDiamondReadable.facetFunctionSelectors.selector;
        selectors[2] = IDiamondReadable.facetAddresses.selector;
        selectors[3] = IDiamondReadable.facetAddress.selector;
        selectors[4] = IDiamondWritable.diamondCut.selector;
    }
}
