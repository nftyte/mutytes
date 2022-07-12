// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721ApprovableController {
    error UnapprovedTokenAction(uint256 tokenId);
    
    error UnapprovedOperatorAction();

    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
}
