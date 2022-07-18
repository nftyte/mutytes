// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721BatchTransferable } from "./IERC721BatchTransferable.sol";
import { ERC721BatchTransferableController } from "./ERC721BatchTransferableController.sol";

/**
 * @title ERC721 batch transfers extension implementation
 */
contract ERC721BatchTransferable is
    IERC721BatchTransferable,
    ERC721BatchTransferableController
{
    /**
     * @inheritdoc IERC721BatchTransferable
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds,
        bytes calldata data
    ) external virtual {
        safeBatchTransferFrom_(from, to, tokenIds, data);
    }

    /**
     * @inheritdoc IERC721BatchTransferable
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual {
        safeBatchTransferFrom_(from, to, tokenIds, "");
    }

    /**
     * @inheritdoc IERC721BatchTransferable
     */
    function batchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual {
        batchTransferFrom_(from, to, tokenIds);
    }
}
