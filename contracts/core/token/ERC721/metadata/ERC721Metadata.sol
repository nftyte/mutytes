// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "./IERC721Metadata.sol";
import { ERC721MetadataController } from "./ERC721MetadataController.sol";

contract ERC721Metadata is IERC721Metadata, ERC721MetadataController {
    function name() external view virtual returns (string memory) {
        return name_();
    }

    function symbol() external view virtual returns (string memory) {
        return symbol_();
    }

    function tokenURI(uint256 tokenId) external view virtual returns (string memory) {
        return tokenURI_(tokenId);
    }
}
