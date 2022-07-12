// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadableController } from "./IDiamondReadableController.sol";

// A loupe is a small magnifying glass used to look at diamonds.
// These functions look at diamonds
interface IDiamondReadable is IDiamondReadableController {
    /// @notice Gets all facet addresses and their four byte function selectors.
    /// @return facets Facet
    function facets() external returns (Facet[] memory);

    /// @notice Gets all the function selectors supported by a specific facet.
    /// @param facet The facet address.
    /// @return selectors
    function facetFunctionSelectors(address facet) external returns (bytes4[] memory);

    /// @notice Get all the facet addresses used by a diamond.
    /// @return facetAddresses
    function facetAddresses() external returns (address[] memory);

    /// @notice Gets the facet that supports the given selector.
    /// @dev If facet is not found return address(0).
    /// @param selector The function selector.
    /// @return facetAddress The facet address.
    function facetAddress(bytes4 selector) external returns (address);
}
