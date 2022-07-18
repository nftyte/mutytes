// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IDiamondReadable } from "./IDiamondReadable.sol";
import { DiamondReadableController } from "./DiamondReadableController.sol";
import { ProxyUpgradableController } from "../../core/proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title Diamond read operations implementation
 * @dev Note: Upgradable implementation
 */
abstract contract DiamondReadableProxy is
    IDiamondReadable,
    DiamondReadableController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IDiamondReadable
     */
    function facets() external virtual upgradable returns (Facet[] memory) {
        return facets_();
    }

    /**
     * @inheritdoc IDiamondReadable
     */
    function facetFunctionSelectors(address facet)
        external
        virtual
        upgradable
        returns (bytes4[] memory)
    {
        return facetFunctionSelectors_(facet);
    }

    /**
     * @inheritdoc IDiamondReadable
     */
    function facetAddresses() external virtual upgradable returns (address[] memory) {
        return facetAddresses_();
    }

    /**
     * @inheritdoc IDiamondReadable
     */
    function facetAddress(bytes4 selector) external virtual upgradable returns (address) {
        return facetAddress_(selector);
    }
}
