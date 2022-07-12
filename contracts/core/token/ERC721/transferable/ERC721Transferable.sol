// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Transferable } from "./IERC721Transferable.sol";
import { ERC721TransferableController } from "./ERC721TransferableController.sol";

abstract contract ERC721Transferable is
    IERC721Transferable,
    ERC721TransferableController
{
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external virtual {
        safeTransferFrom_(from, to, tokenId, data);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual {
        safeTransferFrom_(from, to, tokenId, "");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual {
        transferFrom_(from, to, tokenId);
    }
}
