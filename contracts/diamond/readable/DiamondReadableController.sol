// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadableController } from "./IDiamondReadableController.sol";
import { ProxyFacetedModel } from "../../core/proxy/faceted/ProxyFacetedModel.sol";
import { AddressUtils } from "../../core/utils/AddressUtils.sol";
import { IntegerUtils } from "../../core/utils/IntegerUtils.sol";

abstract contract DiamondReadableController is
    IDiamondReadableController,
    ProxyFacetedModel
{
    using AddressUtils for address;
    using IntegerUtils for uint256;

    function facets_() internal view virtual returns (Facet[] memory facets) {
        address[] memory facetAddresses = _implementations();
        bytes4[][] memory facetFunctions = _functionsByImplementation();
        facets = new Facet[](facetAddresses.length);

        unchecked {
            for (uint256 i; i < facets.length; i++) {
                facets[i].facetAddress = facetAddresses[i];
                facets[i].functionSelectors = facetFunctions[i];
            }
        }
    }

    function facetFunctionSelectors_(address facet)
        internal
        view
        virtual
        returns (bytes4[] memory)
    {
        return _getFunctions(facet);
    }

    function facetAddresses_() internal view virtual returns (address[] memory) {
        return _implementations();
    }

    function facetAddress_(bytes4 selector) internal view virtual returns (address) {
        return _implementation(selector);
    }
}
