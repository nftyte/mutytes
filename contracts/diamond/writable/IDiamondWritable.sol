// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondWritableController } from "./IDiamondWritableController.sol";

interface IDiamondWritable is IDiamondWritableController {
    /// @notice Add/replace/remove any number of functions and optionally execute
    ///         a function with delegatecall
    /// @param facetCuts Contains the facet addresses and function selectors
    /// @param init The address of the contract or facet to execute data
    /// @param data A function call, including function selector and arguments
    ///              data is executed with delegatecall on init
    function diamondCut(
        FacetCut[] calldata facetCuts,
        address init,
        bytes calldata data,
        bool isUpgradable
    ) external;

    function diamondCut(
        FacetCut[] calldata facetCuts,
        address init,
        bytes calldata data
    ) external;
}
