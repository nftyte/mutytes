// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "./IERC165.sol";

abstract contract ERC165Init {
    function _IERC165() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](1);
        selectors[0] = IERC165.supportsInterface.selector;
    }
}
