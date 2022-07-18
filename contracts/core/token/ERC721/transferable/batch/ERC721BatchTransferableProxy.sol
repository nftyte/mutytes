// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721BatchTransferable } from "./IERC721BatchTransferable.sol";
import { ERC721BatchTransferableController } from "./ERC721BatchTransferableController.sol";
import { ProxyUpgradableController } from "../../../../proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title ERC721 batch transfers extension implementation
 * @dev Note: Upgradable implementation
 */
abstract contract ERC721BatchTransferableProxy is
    IERC721BatchTransferable,
    ERC721BatchTransferableController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IERC721BatchTransferable
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds,
        bytes calldata data
    ) external virtual upgradable {
        safeBatchTransferFrom_(from, to, tokenIds, data);
    }

    /**
     * @inheritdoc IERC721BatchTransferable
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual upgradable {
        safeBatchTransferFrom_(from, to, tokenIds, "");
    }

    /**
     * @inheritdoc IERC721BatchTransferable
     */
    function batchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual upgradable {
        batchTransferFrom_(from, to, tokenIds);
    }
}
