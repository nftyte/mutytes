// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Proxy } from "./core/proxy/Proxy.sol";
import { ProxyInit as Initializable } from "./core/proxy/ProxyInit.sol";
import { ProxyUpgradable as Upgradable } from "./core/proxy/upgradable/ProxyUpgradable.sol";
import { ProxyFacetedController as Faceted } from "./core/proxy/faceted/ProxyFacetedController.sol";

contract TestProxy is Proxy, Initializable, Upgradable, Faceted {
    constructor(address init, bytes memory data) Initializable(init, data) {}
}
