// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDiamondWritableController {
    enum FacetCutAction {
        Add,
        Replace,
        Remove
    }

    struct FacetCut {
        address facetAddress;
        FacetCutAction action;
        bytes4[] selectors;
    }

    error UnexpectedFacetCutAction(FacetCutAction action);

    event DiamondCut(FacetCut[] diamondCut, address init, bytes data);
}
