// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Transferable } from "./IERC721Transferable.sol";
import { ERC721TransferableController } from "./ERC721TransferableController.sol";
import { ProxyUpgradable } from "../../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC721TransferableProxy is
    IERC721Transferable,
    ERC721TransferableController,
    ProxyUpgradable
{
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external virtual upgradable {
        safeTransferFrom_(from, to, tokenId, data);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual upgradable {
        safeTransferFrom_(from, to, tokenId, "");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual upgradable {
        transferFrom_(from, to, tokenId);
    }
}
