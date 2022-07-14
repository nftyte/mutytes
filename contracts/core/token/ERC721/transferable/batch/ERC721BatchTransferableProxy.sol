// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BatchTransferable } from "./IERC721BatchTransferable.sol";
import { ERC721BatchTransferableController } from "./ERC721BatchTransferableController.sol";
import { ProxyUpgradableController } from "../../../../proxy/upgradable/ProxyUpgradableController.sol";

abstract contract ERC721BatchTransferableProxy is
    IERC721BatchTransferable,
    ERC721BatchTransferableController,
    ProxyUpgradableController
{
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds,
        bytes calldata data
    ) external virtual upgradable {
        safeBatchTransferFrom_(from, to, tokenIds, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual upgradable {
        safeBatchTransferFrom_(from, to, tokenIds, "");
    }

    function batchTransferFrom(
        address from,
        address to,
        uint256[] calldata tokenIds
    ) external virtual upgradable {
        batchTransferFrom_(from, to, tokenIds);
    }
}
