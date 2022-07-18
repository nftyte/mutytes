// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721ApprovableController } from "./IERC721ApprovableController.sol";

/**
 * @title ERC721 approvals interface
 */
interface IERC721Approvable is IERC721ApprovableController {
    /**
     * @notice Grant approval to a token
     * @param approved The address to approve
     * @param tokenId The token id
     */
    function approve(address approved, uint256 tokenId) external;

    /**
     * @notice Set operator approval
     * @param operator The operator's address
     * @param approved Whether to grant approval
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @notice Get the approved address of a token
     * @param tokenId The token id
     * @return approved The approved address
     */
    function getApproved(uint256 tokenId) external returns (address);

    /**
     * @notice Query whether the operator is approved for an address
     * @param owner The address to query
     * @param operator The operator's address
     * @return isApproved Whether the operator is approved
     */
    function isApprovedForAll(address owner, address operator) external returns (bool);
}
