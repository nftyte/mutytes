// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ProxyFacetedStorage, SelectorInfo } from "../ProxyFacetedStorage.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";

library ProxyFacetedUtils {
    using AddressUtils for address;
    
    function addFunctions(
        ProxyFacetedStorage storage pfs,
        address implementation,
        bytes4[] memory selectors,
        bool isUpgradable
    ) internal {
        require(selectors.length > 0, "ProxyFacetedUtils: No selectors to add");
        uint16 count = uint16(pfs.selectors.length);
        require(implementation != address(0), "ProxyFacetedUtils: Add implementation can't be address(0)");
        if (implementation != address(this)) {
            require(implementation.hasContractCode(), "ProxyFacetedUtils: Add implementation has no code");
        }
        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            address oldImplementation = pfs.selectorInfo[selector].implementation;
            require(oldImplementation == address(0), "ProxyFacetedUtils: Can't add function that already exists");
            pfs.selectorInfo[selector] = SelectorInfo(isUpgradable, count, implementation);
            pfs.selectors.push(selector);
            count++;
        }
    }

    function replaceFunctions(
        ProxyFacetedStorage storage pfs,
        address implementation,
        bytes4[] memory selectors
    ) internal {
        require(selectors.length > 0, "ProxyFacetedUtils: No selectors to replace");
        require(implementation != address(0), "ProxyFacetedUtils: Replace implementation can't be address(0)");
        require(implementation.hasContractCode(), "ProxyFacetedUtils: Replace implementation has no code");
        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            SelectorInfo memory oldSelector = pfs.selectorInfo[selector];
            address oldImplementation = oldSelector.implementation;
            // can't replace immutable functions -- functions defined directly in the proxy w/o upgradability
            if (!oldSelector.isUpgradable) {
                require(oldImplementation != address(this), "ProxyFacetedUtils: Can't replace immutable function");
            }
            require(oldImplementation != implementation, "ProxyFacetedUtils: Can't replace function with same function");
            require(oldImplementation != address(0), "ProxyFacetedUtils: Can't replace function that doesn't exist");
            // replace old implementation address
            pfs.selectorInfo[selector].implementation = implementation;
        }
    }

    function removeFunctions(
        ProxyFacetedStorage storage pfs,
        address implementation,
        bytes4[] memory selectors
    ) internal {
        require(selectors.length > 0, "ProxyFacetedUtils: No selectors to remove");
        uint256 count = pfs.selectors.length;
        require(implementation == address(0), "ProxyFacetedUtils: Remove implementation must be address(0)");
        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            SelectorInfo memory oldSelector = pfs.selectorInfo[selector];
            require(oldSelector.implementation != address(0), "ProxyFacetedUtils: Can't remove function that doesn't exist");
            // can't remove immutable functions -- functions defined directly in the proxy w/o upgradability
            if (!oldSelector.isUpgradable) {
                require(oldSelector.implementation != address(this), "ProxyFacetedUtils: Can't remove immutable function.");
            }
            // replace selector with last selector
            count--;
            if (oldSelector.position != count) {
                bytes4 lastSelector = pfs.selectors[count];
                pfs.selectors[oldSelector.position] = lastSelector;
                pfs.selectorInfo[lastSelector].position = oldSelector.position;
            }
            // delete last selector
            pfs.selectors.pop();
            delete pfs.selectorInfo[selector];
        }
    }
}