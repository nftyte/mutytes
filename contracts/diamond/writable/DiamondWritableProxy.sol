// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IDiamondWritable } from "./IDiamondWritable.sol";
import { DiamondWritableController } from "./DiamondWritableController.sol";
import { ProxyUpgradableController } from "../../core/proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title Diamond write operations implementation
 * @dev Note: Upgradable implementation
 */
abstract contract DiamondWritableProxy is
    IDiamondWritable,
    DiamondWritableController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IDiamondWritable
     */
    function diamondCut(
        FacetCut[] calldata facetCuts,
        address init,
        bytes calldata data
    ) external virtual upgradable onlyOwner {
        diamondCut_(facetCuts, init, data);
    }
}
