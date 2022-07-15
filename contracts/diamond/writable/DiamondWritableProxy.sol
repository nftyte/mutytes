// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondWritable } from "./IDiamondWritable.sol";
import { DiamondWritableController } from "./DiamondWritableController.sol";
import { ProxyUpgradableController } from "../../core/proxy/upgradable/ProxyUpgradableController.sol";

abstract contract DiamondWritableProxy is
    IDiamondWritable,
    DiamondWritableController,
    ProxyUpgradableController
{
    function diamondCut(
        FacetCut[] calldata facetCuts,
        address init,
        bytes calldata data
    ) external virtual upgradable {
        diamondCut_(facetCuts, init, data, false);
    }
}
