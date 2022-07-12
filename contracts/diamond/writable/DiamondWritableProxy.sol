// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondWritable } from "./IDiamondWritable.sol";
import { DiamondWritableController } from "./DiamondWritableController.sol";
import { ProxyUpgradable } from "../../core/proxy/upgradable/ProxyUpgradable.sol";

abstract contract DiamondWritableProxy is
    IDiamondWritable,
    DiamondWritableController,
    ProxyUpgradable
{
    function diamondCut(
        FacetCut[] calldata facetCuts,
        address init,
        bytes calldata data
    ) external virtual upgradable {
        diamondCut_(facetCuts, init, data);
    }
}
