// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "./IERC721Metadata.sol";
import { ERC721 } from "../ERC721.sol";

abstract contract ERC721Metadata is IERC721Metadata, ERC721 {
    function name() external view virtual override returns (string memory);

    function symbol() external view virtual override returns (string memory);

    function tokenURI(uint256 tokenId) external view virtual override returns (string memory);
}