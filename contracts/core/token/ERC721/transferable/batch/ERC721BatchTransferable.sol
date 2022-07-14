// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BatchTransferable } from "./IERC721BatchTransferable.sol";
import { ERC721BatchTransferableController } from "./ERC721BatchTransferableController.sol";

contract ERC721BatchTransferable is
    IERC721BatchTransferable,
    ERC721BatchTransferableController
{
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds,
        bytes calldata data
    ) external virtual {
        safeBatchTransferFrom_(from, to, tokenIds, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual {
        safeBatchTransferFrom_(from, to, tokenIds, "");
    }

    function batchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual {
        batchTransferFrom_(from, to, tokenIds);
    }
}
