// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadable } from "./IDiamondReadable.sol";
import { DiamondReadableController } from "./DiamondReadableController.sol";
import { ProxyUpgradable } from "../../core/proxy/upgradable/ProxyUpgradable.sol";

abstract contract DiamondReadableProxy is
    IDiamondReadable,
    DiamondReadableController,
    ProxyUpgradable
{
    function facets() external virtual upgradable returns (Facet[] memory) {
        return facets_();
    }

    function facetFunctionSelectors(address facet)
        external
        virtual
        upgradable
        returns (bytes4[] memory)
    {
        return facetFunctionSelectors_(facet);
    }

    function facetAddresses() external virtual upgradable returns (address[] memory) {
        return facetAddresses_();
    }

    function facetAddress(bytes4 selector) external virtual upgradable returns (address) {
        return facetAddress_(selector);
    }
}
