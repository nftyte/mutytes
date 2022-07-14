// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadable } from "./IDiamondReadable.sol";

abstract contract DiamondReadableInit {
    function _IDiamondReadable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](4);
        selectors[0] = IDiamondReadable.facets.selector;
        selectors[1] = IDiamondReadable.facetFunctionSelectors.selector;
        selectors[2] = IDiamondReadable.facetAddresses.selector;
        selectors[3] = IDiamondReadable.facetAddress.selector;
    }
}
