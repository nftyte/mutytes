// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TransferableController } from "../IERC721Transferable.sol";

/**
 * @title ERC721 batch transfers extension interface
 */
interface IERC721BatchTransferable is IERC721TransferableController {
    /**
     * @notice Transfer tokens between addresses
     * @dev Preforms ERC721Receiver check if applicable
     * @param from The tokens' owner address
     * @param to The recipient address
     * @param tokenIds The token ids
     * @param data Additional data
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds,
        bytes calldata data
    ) external;

    /**
     * @notice Transfer tokens between addresses
     * @dev Preforms ERC721Receiver check if applicable
     * @param from The tokens' owner address
     * @param to The recipient address
     * @param tokenIds The token ids
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external;

    /**
     * @notice Transfer tokens between addresses
     * @param from The tokens' owner address
     * @param to The recipient address
     * @param tokenIds The token ids
     */
    function batchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external;
}
