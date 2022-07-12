// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Controller } from "./IERC721Controller.sol";

interface IERC721 is IERC721Controller {
    function balanceOf(address owner) external returns (uint256);

    function ownerOf(uint256 tokenId) external returns (address);

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    function transferFrom(address from, address to, uint256 tokenId) external;

    function approve(address approved, uint256 tokenId) external;

    function setApprovalForAll(address operator, bool approved) external;

    function getApproved(uint256 tokenId) external returns (address);

    function isApprovedForAll(address owner, address operator) external returns (bool);
}
