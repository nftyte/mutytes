// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { MutytesTokenProxy } from "./token/MutytesTokenProxy.sol";
import { SafeOwnableProxy } from "../core/access/ownable/safe/SafeOwnableProxy.sol";
import { ProxyFacetedController as ProxyFaceted } from "../core/proxy/faceted/ProxyFacetedController.sol";
import { Proxy } from "../core/proxy/Proxy.sol";

contract Mutytes is MutytesTokenProxy, SafeOwnableProxy, ProxyFaceted, Proxy {
    constructor(address init, bytes memory data) {
        MutytesToken_();
        Ownable_();
        Proxy_(init, data);
    }
}
