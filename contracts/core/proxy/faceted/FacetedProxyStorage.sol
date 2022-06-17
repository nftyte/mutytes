// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { FacetedProxyUtils } from "./utils/FacetedProxyUtils.sol";

using FacetedProxyUtils for FacetedProxyStorage global;

bytes32 constant FACETED_PROXY_STORAGE_SLOT = keccak256("core.proxy.faceted.storage");

struct SelectorInfo {
    bool isUpgradable;
    uint16 position;
    address implementation;
}

struct FacetedProxyStorage {
    mapping(bytes4 => SelectorInfo) selectorInfo;
    bytes4[] selectors;
}

function facetedProxyStorage() pure returns (FacetedProxyStorage storage fps) {
    bytes32 slot = FACETED_PROXY_STORAGE_SLOT;
    assembly {
        fps.slot := slot
    }
}
