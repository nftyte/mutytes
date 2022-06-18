// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "./IERC721Metadata.sol";
import { ERC721MetadataInternal } from "./ERC721MetadataInternal.sol";

abstract contract ERC721Metadata is IERC721Metadata, ERC721MetadataInternal {
    function name() external view virtual override returns (string memory) {
        return _name();
    }

    function symbol() external view virtual override returns (string memory) {
        return _symbol();
    }

    function tokenURI(uint256 tokenId)
        external
        view
        virtual
        override
        returns (string memory)
    {
        return _tokenURI(tokenId);
    }
}
