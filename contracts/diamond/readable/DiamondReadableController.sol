// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadable } from "./IDiamondReadable.sol";
import { IDiamondReadableController } from "./IDiamondReadableController.sol";
import { DiamondReadableModel } from "./DiamondReadableModel.sol";
import { ProxyFacetedController } from "../../core/proxy/faceted/ProxyFacetedController.sol";

abstract contract DiamondReadableController is
    IDiamondReadableController,
    DiamondReadableModel,
    ProxyFacetedController
{
    function IDiamondReadable_()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](4);
        selectors[0] = IDiamondReadable.facets.selector;
        selectors[1] = IDiamondReadable.facetFunctionSelectors.selector;
        selectors[2] = IDiamondReadable.facetAddresses.selector;
        selectors[3] = IDiamondReadable.facetAddress.selector;
    }

    function facets_() internal view virtual returns (Facet[] memory) {
        return _facets();
    }

    function facetFunctionSelectors_(address facet)
        internal
        view
        virtual
        returns (bytes4[] memory)
    {
        return _facetFunctionSelectors(facet);
    }

    function facetAddresses_() internal view virtual returns (address[] memory) {
        return _facetAddresses();
    }

    function facetAddress_(bytes4 selector) internal view virtual returns (address) {
        return _implementation(selector);
    }
}
