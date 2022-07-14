// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ISafeOwnable, IERC173 } from "./ISafeOwnable.sol";

abstract contract SafeOwnableInit {
    function _ISafeOwnable() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](4);
        selectors[0] = IERC173.owner.selector;
        selectors[1] = IERC173.transferOwnership.selector;
        selectors[2] = ISafeOwnable.nomineeOwner.selector;
        selectors[3] = ISafeOwnable.acceptOwnership.selector;
    }
}
