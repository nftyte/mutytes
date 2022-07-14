// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Burnable } from "./IERC721Burnable.sol";

abstract contract ERC721BurnableInit {
    function _IERC721Burnable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](1);
        selectors[0] = IERC721Burnable.burn.selector;
    }
}
