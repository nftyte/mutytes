// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Proxy } from "./core/proxy/Proxy.sol";
import { ProxyUpgradableController as Upgradable } from "./core/proxy/upgradable/ProxyUpgradableController.sol";
import { ProxyFacetedController as Faceted } from "./core/proxy/faceted/ProxyFacetedController.sol";

contract TestProxy is Proxy, Upgradable, Faceted {
    constructor(address init, bytes memory data) {
        Proxy_(init, data);
    }
}
