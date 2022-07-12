// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ProxyFacetedModel } from "./ProxyFacetedModel.sol";
import { ProxyModel } from "../ProxyModel.sol";
import { AddressUtils } from "../../utils/AddressUtils.sol";

abstract contract ProxyFacetedController is ProxyFacetedModel, ProxyModel {
    using AddressUtils for address;

    function addFunction_(
        address implementation,
        bytes4 selector,
        bool isUpgradable
    ) internal virtual {
        _enforceCanAddFunctions(implementation);
        _enforceCanAddFunction(selector, implementation);
        _addFunction(selector, implementation, isUpgradable);
    }

    function addFunctions_(
        address implementation,
        bytes4[] memory selectors,
        bool isUpgradable
    ) internal virtual {
        _enforceCanAddFunctions(implementation);

        unchecked {
            for (uint256 i; i < selectors.length; i++) {
                bytes4 selector = selectors[i];
                _enforceCanAddFunction(selector, implementation);
                _addFunction(selector, implementation, isUpgradable);
            }
        }
    }

    function replaceFunction_(address implementation, bytes4 selector) internal virtual {
        _enforceCanAddFunctions(implementation);
        _enforceCanReplaceFunction(selector, implementation);
        _setImplementation(selector, implementation);
    }

    function replaceFunctions_(address implementation, bytes4[] memory selectors)
        internal
        virtual
    {
        _enforceCanAddFunctions(implementation);

        unchecked {
            for (uint256 i; i < selectors.length; i++) {
                bytes4 selector = selectors[i];
                _enforceCanReplaceFunction(selector, implementation);
                _setImplementation(selector, implementation);
            }
        }
    }

    function removeFunction_(bytes4 selector) internal virtual {
        _enforceCanRemoveFunction(selector, _implementation(selector));
        _removeFunction(selector);
    }

    function removeFunctions_(bytes4[] memory selectors) internal virtual {
        unchecked {
            for (uint256 i; i < selectors.length; i++) {
                removeFunction_(selectors[i]);
            }
        }
    }

    function _enforceCanAddFunctions(address implementation) internal view virtual {
        if (implementation == address(this)) {
            return;
        }
        
        implementation.enforceIsContract();
    }

    function _enforceCanAddFunction(bytes4 selector, address) internal view virtual {
        _implementation(selector).enforceIsZeroAddress();
    }

    function _enforceCanReplaceFunction(bytes4 selector, address implementation)
        internal
        view
        virtual
    {
        address oldImplementation = _implementation(selector);
        oldImplementation.enforceNotEquals(implementation);
        _enforceCanRemoveFunction(selector, oldImplementation);
    }

    function _enforceCanRemoveFunction(bytes4 selector, address implementation)
        internal
        view
        virtual
    {
        implementation.enforceIsNotZeroAddress();

        if (_isUpgradable(selector)) {
            return;
        }
        
        // Can't remove immutable functions - functions defined directly in the proxy w/o upgradability
        implementation.enforceNotEquals(address(this));
    }

    function _implementation() internal view virtual override returns (address) {
        return _implementation(msg.sig);
    }
}
