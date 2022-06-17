// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { FacetedProxyStorage, SelectorInfo } from "../FacetedProxyStorage.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";

library FacetedProxyUtils {
    using AddressUtils for address;
    
    function addFunctions(
        FacetedProxyStorage storage fps,
        address implementation,
        bytes4[] memory selectors,
        bool isUpgradable
    ) internal {
        require(selectors.length > 0, "FacetedProxyUtils: No selectors to add");
        uint16 count = uint16(fps.selectors.length);
        require(implementation != address(0), "FacetedProxyUtils: Add implementation can't be address(0)");
        if (implementation != address(this)) {
            require(implementation.hasContractCode(), "FacetedProxyUtils: Add implementation has no code");
        }
        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            address oldImplementation = fps.selectorInfo[selector].implementation;
            require(oldImplementation == address(0), "FacetedProxyUtils: Can't add function that already exists");
            fps.selectorInfo[selector] = SelectorInfo(isUpgradable, count, implementation);
            fps.selectors.push(selector);
            count++;
        }
    }

    function replaceFunctions(
        FacetedProxyStorage storage fps,
        address implementation,
        bytes4[] memory selectors
    ) internal {
        require(selectors.length > 0, "FacetedProxyUtils: No selectors to replace");
        require(implementation != address(0), "FacetedProxyUtils: Replace implementation can't be address(0)");
        require(implementation.hasContractCode(), "FacetedProxyUtils: Replace implementation has no code");
        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            SelectorInfo memory oldSelector = fps.selectorInfo[selector];
            address oldImplementation = oldSelector.implementation;
            // can't replace immutable functions -- functions defined directly in the proxy w/o upgradability
            if (!oldSelector.isUpgradable) {
                require(oldImplementation != address(this), "FacetedProxyUtils: Can't replace immutable function");
            }
            require(oldImplementation != implementation, "FacetedProxyUtils: Can't replace function with same function");
            require(oldImplementation != address(0), "FacetedProxyUtils: Can't replace function that doesn't exist");
            // replace old implementation address
            fps.selectorInfo[selector].implementation = implementation;
        }
    }

    function removeFunctions(
        FacetedProxyStorage storage fps,
        address implementation,
        bytes4[] memory selectors
    ) internal {
        require(selectors.length > 0, "FacetedProxyUtils: No selectors to remove");
        uint256 count = fps.selectors.length;
        require(implementation == address(0), "FacetedProxyUtils: Remove implementation must be address(0)");
        for (uint256 i; i < selectors.length; i++) {
            bytes4 selector = selectors[i];
            SelectorInfo memory oldSelector = fps.selectorInfo[selector];
            require(oldSelector.implementation != address(0), "FacetedProxyUtils: Can't remove function that doesn't exist");
            // can't remove immutable functions -- functions defined directly in the proxy w/o upgradability
            if (!oldSelector.isUpgradable) {
                require(oldSelector.implementation != address(this), "FacetedProxyUtils: Can't remove immutable function.");
            }
            // replace selector with last selector
            count--;
            if (oldSelector.position != count) {
                bytes4 lastSelector = fps.selectors[count];
                fps.selectors[oldSelector.position] = lastSelector;
                fps.selectorInfo[lastSelector].position = oldSelector.position;
            }
            // delete last selector
            fps.selectors.pop();
            delete fps.selectorInfo[selector];
        }
    }
}