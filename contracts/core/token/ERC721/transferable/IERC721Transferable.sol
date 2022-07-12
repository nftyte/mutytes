// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TransferableController } from "./IERC721TransferableController.sol";

interface IERC721Transferable is IERC721TransferableController {
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    function transferFrom(address from, address to, uint256 tokenId) external;
}
