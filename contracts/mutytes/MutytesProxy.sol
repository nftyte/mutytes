// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { MutytesTokenProxy } from "./token/MutytesTokenProxy.sol";
import { SafeOwnableProxy } from "../core/access/ownable/safe/SafeOwnableProxy.sol";
import { ProxyFaceted } from "../core/proxy/faceted/ProxyFaceted.sol";
import { Proxy } from "../core/proxy/Proxy.sol";

contract MutytesProxy is
    MutytesTokenProxy,
    SafeOwnableProxy,
    ProxyFaceted,
    Proxy
{
    constructor(address init, bytes memory data) {
        Proxy_(init, data);
    }
}
