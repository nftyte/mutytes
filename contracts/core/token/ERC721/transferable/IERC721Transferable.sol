// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TransferableController } from "./IERC721TransferableController.sol";

/**
 * @title ERC721 token transfers interface
 */
interface IERC721Transferable is IERC721TransferableController {
    /**
     * @notice Transfer a token between addresses
     * @dev Preforms ERC721Receiver check if applicable
     * @param from The token's owner address
     * @param to The recipient address
     * @param tokenId The token id
     * @param data Additional data
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @notice Transfer a token between addresses
     * @dev Preforms ERC721Receiver check if applicable
     * @param from The token's owner address
     * @param to The recipient address
     * @param tokenId The token id
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @notice Transfer a token between addresses
     * @param from The token's owner address
     * @param to The recipient address
     * @param tokenId The token id
     */
    function transferFrom(address from, address to, uint256 tokenId) external;
}
