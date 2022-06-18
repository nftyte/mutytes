// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ProxyFacetedUtils } from "./utils/ProxyFacetedUtils.sol";

using ProxyFacetedUtils for ProxyFacetedStorage global;

bytes32 constant FACETED_PROXY_STORAGE_SLOT = keccak256("core.proxy.faceted.storage");

struct SelectorInfo {
    bool isUpgradable;
    uint16 position;
    address implementation;
}

struct ProxyFacetedStorage {
    mapping(bytes4 => SelectorInfo) selectorInfo;
    bytes4[] selectors;
}

function proxyFacetedStorage() pure returns (ProxyFacetedStorage storage fps) {
    bytes32 slot = FACETED_PROXY_STORAGE_SLOT;
    assembly {
        fps.slot := slot
    }
}
