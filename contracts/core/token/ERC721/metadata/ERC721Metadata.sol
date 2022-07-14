// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "./IERC721Metadata.sol";
import { ERC721MetadataController } from "./ERC721MetadataController.sol";
import { ERC721TokenURIController } from "../tokenURI/ERC721TokenURIController.sol";

contract ERC721Metadata is
    IERC721Metadata,
    ERC721MetadataController,
    ERC721TokenURIController
{
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
