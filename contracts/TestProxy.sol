// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Proxy } from "./core/proxy/Proxy.sol";
import { ProxyUpgradable as Upgradable } from "./core/proxy/upgradable/ProxyUpgradable.sol";
import { ProxyFaceted as Faceted } from "./core/proxy/faceted/ProxyFaceted.sol";

contract TestProxy is Proxy, Upgradable, Faceted {
    constructor(address init, bytes memory data) {
        Proxy_(init, data);
    }
}
