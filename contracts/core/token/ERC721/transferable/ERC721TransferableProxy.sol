// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Transferable } from "./IERC721Transferable.sol";
import { ERC721TransferableController } from "./ERC721TransferableController.sol";
import { ProxyUpgradableController } from "../../../proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title ERC721 token transfers implementation
 * @dev Note: Upgradable implementation
 */
abstract contract ERC721TransferableProxy is
    IERC721Transferable,
    ERC721TransferableController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IERC721Transferable
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external virtual upgradable {
        safeTransferFrom_(from, to, tokenId, data);
    }

    /**
     * @inheritdoc IERC721Transferable
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual upgradable {
        safeTransferFrom_(from, to, tokenId, "");
    }

    /**
     * @inheritdoc IERC721Transferable
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual upgradable {
        transferFrom_(from, to, tokenId);
    }
}
