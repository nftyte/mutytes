// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { proxyFacetedStorage, ProxyFacetedStorage, SelectorInfo } from "./ProxyFacetedStorage.sol";

abstract contract ProxyFacetedModel {
    function _addFunction(
        bytes4 selector,
        address implementation,
        bool isUpgradable
    ) internal virtual {
        ProxyFacetedStorage storage ps = proxyFacetedStorage();
        ps.selectorInfo[selector] = SelectorInfo(
            isUpgradable,
            uint16(ps.selectors.length),
            implementation
        );
        ps.selectors.push(selector);
    }

    function _removeFunction(bytes4 selector) internal virtual {
        ProxyFacetedStorage storage ps = proxyFacetedStorage();
        uint16 position = ps.selectorInfo[selector].position;
        uint256 lastPosition = ps.selectors.length - 1;

        if (position != lastPosition) {
            bytes4 lastSelector = ps.selectors[lastPosition];
            ps.selectors[position] = lastSelector;
            ps.selectorInfo[lastSelector].position = position;
        }

        ps.selectors.pop();
        delete ps.selectorInfo[selector];
    }

    function _setImplementation(bytes4 selector, address implementation)
        internal
        virtual
    {
        proxyFacetedStorage().selectorInfo[selector].implementation = implementation;
    }

    function _implementation(bytes4 selector) internal view virtual returns (address) {
        return proxyFacetedStorage().selectorInfo[selector].implementation;
    }

    function _isUpgradable(bytes4 selector) internal view virtual returns (bool) {
        return proxyFacetedStorage().selectorInfo[selector].isUpgradable;
    }
}
