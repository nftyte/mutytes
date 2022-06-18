// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Proxy } from "./core/proxy/Proxy.sol";
import { ProxyFaceted as Faceted } from "./core/proxy/faceted/ProxyFaceted.sol";
import { ProxyUpgradable as Upgradable } from "./core/proxy/upgradable/ProxyUpgradable.sol";
import { ProxyInitializable as Initializable } from "./core/proxy/initializable/ProxyInitializable.sol";

contract TestProxy is Proxy, Initializable, Upgradable, Faceted {
    constructor(address init, bytes memory data) Initializable(init, data) {}
}