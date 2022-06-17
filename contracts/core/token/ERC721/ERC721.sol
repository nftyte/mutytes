// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";

abstract contract ERC721 is IERC721 {
    function balanceOf(address owner) external view virtual override returns (uint256);

    function ownerOf(uint256 tokenId) external view virtual override returns (address);

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external virtual override;

    function safeTransferFrom(address from, address to, uint256 tokenId) external virtual override;

    function transferFrom(address from, address to, uint256 tokenId) external virtual override;

    function approve(address approved, uint256 tokenId) external virtual override;

    function setApprovalForAll(address operator, bool approved) external virtual override;

    function getApproved(uint256 tokenId) external view virtual override returns (address);

    function isApprovedForAll(address owner, address operator) external view virtual override returns (bool);
}