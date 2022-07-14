// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Base } from "./IERC721Base.sol";

abstract contract ERC721BaseInit {
    function _IERC721Base() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](2);
        selectors[0] = IERC721Base.balanceOf.selector;
        selectors[1] = IERC721Base.ownerOf.selector;
    }
}
