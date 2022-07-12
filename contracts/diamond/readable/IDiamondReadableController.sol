// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDiamondReadableController {
    struct Facet {
        address facetAddress;
        bytes4[] functionSelectors;
    }
}
