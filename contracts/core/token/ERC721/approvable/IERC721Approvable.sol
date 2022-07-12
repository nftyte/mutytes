// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721ApprovableController } from "./IERC721ApprovableController.sol";

interface IERC721Approvable is IERC721ApprovableController {
    function approve(address approved, uint256 tokenId) external;

    function setApprovalForAll(address operator, bool approved) external;

    function getApproved(uint256 tokenId) external returns (address);

    function isApprovedForAll(address owner, address operator) external returns (bool);
}
