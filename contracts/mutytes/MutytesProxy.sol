// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { MutytesTokenProxy } from "./token/MutytesTokenProxy.sol";
import { Proxy } from "../core/proxy/Proxy.sol";
import { ProxyInit } from "../core/proxy/ProxyInit.sol";
import { ProxyFaceted } from "../core/proxy/faceted/ProxyFaceted.sol";
import { SafeOwnableProxy } from "../core/access/ownable/safe/SafeOwnableProxy.sol";

contract MutytesProxy is
    MutytesTokenProxy,
    Proxy,
    ProxyInit,
    ProxyFaceted,
    SafeOwnableProxy
{
    constructor(address init, bytes memory data) ProxyInit(init, data) {}
}
