// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondWritable } from "./IDiamondWritable.sol";

abstract contract DiamondWritableInit {
    function _IDiamondWritable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](1);
        selectors[0] = IDiamondWritable.diamondCut.selector;
    }
}
