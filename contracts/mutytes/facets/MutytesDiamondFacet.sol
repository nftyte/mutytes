// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Diamond } from "../../diamond/Diamond.sol";
import { IDiamondWritable } from "../../diamond/writable/IDiamondWritable.sol";

bytes constant SELECTORS_BYTECODE = abi.encode(1, IDiamondWritable.diamondCut.selector);

/**
 * @title Mutytes diamond implementation facet
 */
contract MutytesDiamondFacet is Diamond {
    /**
     * @notice Initialize the diamond proxy
     * @param facetAddress The diamond facet address
     */
    function init(address facetAddress) external virtual onlyOwner {
        FacetCut[] memory facetCuts = new FacetCut[](1);
        facetCuts[0] = FacetCut(facetAddress, FacetCutAction.Add, _selectors());
        diamondCut_(facetCuts, address(0), "");
    }

    function _selectors() internal pure virtual returns (bytes4[] memory selectors) {
        bytes memory selectorsPtr = SELECTORS_BYTECODE;
        assembly {
            selectors := add(selectorsPtr, 0x20)
        }
    }
}
