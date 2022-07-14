// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadable } from "./IDiamondReadable.sol";
import { DiamondReadableController } from "./DiamondReadableController.sol";

contract DiamondReadable is IDiamondReadable, DiamondReadableController {
    function facets() external view virtual returns (Facet[] memory) {
        return facets_();
    }

    function facetFunctionSelectors(address facet)
        external
        view
        virtual
        returns (bytes4[] memory)
    {
        return facetFunctionSelectors_(facet);
    }

    function facetAddresses() external view virtual returns (address[] memory) {
        return facetAddresses_();
    }

    function facetAddress(bytes4 selector) external view virtual returns (address) {
        return facetAddress_(selector);
    }
}
