// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { proxyFacetedStorage, ProxyFacetedStorage, SelectorInfo, ImplementationInfo } from "./ProxyFacetedStorage.sol";

abstract contract ProxyFacetedModel {
    function _implementations()
        internal
        view
        virtual
        returns (address[] memory implementations)
    {
        return proxyFacetedStorage().implementations;
    }

    function _implementation(bytes4 selector) internal view virtual returns (address) {
        return proxyFacetedStorage().selectorInfo[selector].implementation;
    }

    function _functionsByImplementation()
        internal
        view
        virtual
        returns (bytes4[][] memory selectors)
    {
        ProxyFacetedStorage storage ps = proxyFacetedStorage();
        uint256 count = ps.implementations.length;
        uint256[] memory current = new uint256[](count);
        selectors = new bytes4[][](count);

        unchecked {
            for (uint256 i; i < count; i++) {
                uint256 selectorCount = ps
                    .implementationInfo[ps.implementations[i]]
                    .selectorCount;
                selectors[i] = new bytes4[](selectorCount);
            }

            for (uint256 i; i < ps.selectors.length; i++) {
                bytes4 selector = ps.selectors[i];
                uint256 position = ps
                    .implementationInfo[ps.selectorInfo[selector].implementation]
                    .position;
                selectors[current[position]++][position] = selector;
            }
        }
    }

    function _getFunctions(address implementation)
        internal
        view
        virtual
        returns (bytes4[] memory selectors)
    {
        ProxyFacetedStorage storage ps = proxyFacetedStorage();
        uint256 selectorCount = ps.implementationInfo[implementation].selectorCount;
        selectors = new bytes4[](selectorCount);
        uint256 index;

        unchecked {
            for (uint256 i; index < selectorCount; i++) {
                bytes4 selector = ps.selectors[i];

                if (ps.selectorInfo[selector].implementation == implementation) {
                    selectors[index++] = selector;
                }
            }
        }
    }

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

    function _replaceFunction(bytes4 selector, address implementation) internal virtual {
        proxyFacetedStorage().selectorInfo[selector].implementation = implementation;
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

    function _afterAddFunction(address implementation) internal virtual {
        ProxyFacetedStorage storage ps = proxyFacetedStorage();
        ImplementationInfo storage info = ps.implementationInfo[implementation];
        uint16 selectorCount = info.selectorCount + 1;

        if (selectorCount == 1) {
            info.position = uint16(ps.implementations.length);
            ps.implementations.push(implementation);
        }

        info.selectorCount = selectorCount;
    }

    function _afterRemoveFunction(address implementation) internal virtual {
        ProxyFacetedStorage storage ps = proxyFacetedStorage();
        ImplementationInfo storage info = ps.implementationInfo[implementation];
        uint16 selectorCount = info.selectorCount - 1;

        if (selectorCount == 0) {
            uint16 position = info.position;
            uint256 lastPosition = ps.implementations.length - 1;

            if (position != lastPosition) {
                address lastImplementation = ps.implementations[lastPosition];
                ps.implementations[position] = lastImplementation;
                ps.implementationInfo[lastImplementation].position = position;
            }

            ps.implementations.pop();
            delete ps.implementationInfo[implementation];
        } else {
            info.selectorCount = selectorCount;
        }
    }

    function _isUpgradable(bytes4 selector) internal view virtual returns (bool) {
        return proxyFacetedStorage().selectorInfo[selector].isUpgradable;
    }
}
