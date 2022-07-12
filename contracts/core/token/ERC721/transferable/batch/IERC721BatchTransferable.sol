// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TransferableController } from "../IERC721Transferable.sol";

interface IERC721BatchTransferable is IERC721TransferableController {
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds,
        bytes calldata data
    ) external;

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external;

    function batchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external;
}
