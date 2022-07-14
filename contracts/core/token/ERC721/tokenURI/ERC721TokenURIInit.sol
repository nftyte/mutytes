// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TokenURI } from "./IERC721TokenURI.sol";

abstract contract ERC721TokenURIInit {
    function _IERC721TokenURI()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](1);
        selectors[0] = IERC721TokenURI.tokenURI.selector;
    }
}
