// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Proxy } from "./core/proxy/Proxy.sol";
import { FacetedProxy as Faceted } from "./core/proxy/faceted/FacetedProxy.sol";
import { UpgradableProxy as Upgradable } from "./core/proxy/upgradable/UpgradableProxy.sol";
import { InitializableProxy as Initializable } from "./core/proxy/initializable/InitializableProxy.sol";

contract TestProxy is Proxy, Initializable, Upgradable, Faceted {
    constructor(address init, bytes memory data) Initializable(init, data) {}
}