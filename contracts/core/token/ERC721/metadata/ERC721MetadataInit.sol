// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "./IERC721Metadata.sol";

abstract contract ERC721MetadataInit {
    function _IERC721Metadata()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](3);
        selectors[0] = IERC721Metadata.name.selector;
        selectors[1] = IERC721Metadata.symbol.selector;
        selectors[2] = IERC721Metadata.tokenURI.selector;
    }
}
