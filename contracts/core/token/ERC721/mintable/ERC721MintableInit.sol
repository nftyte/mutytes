// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Mintable } from "./IERC721Mintable.sol";

abstract contract ERC721MintableInit {
    function _IERC721Mintable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](1);
        selectors[0] = IERC721Mintable.mint.selector;
    }
}
