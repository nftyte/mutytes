// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173 } from "../IERC173.sol";

abstract contract OwnableInit {
    function _IOwnable() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](2);
        selectors[0] = IERC173.owner.selector;
        selectors[1] = IERC173.transferOwnership.selector;
    }
}
