// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Diamond } from "../../diamond/Diamond.sol";
import { IDiamondWritable } from "../../diamond/writable/IDiamondWritable.sol";
import { IERC165 } from "../../core/introspection/IERC165.sol";

bytes constant DIAMOND_SELECTORS = abi.encode(1, IDiamondWritable.diamondCut.selector);
bytes constant ERC165_SELECTORS = abi.encode(1, IERC165.supportsInterface.selector);

/**
 * @title Mutytes diamond implementation facet
 */
contract MutytesDiamondFacet is Diamond {
    /**
     * @notice Initialize the diamond proxy
     * @param facetAddress The diamond facet address
     */
    function init(address facetAddress) external virtual onlyOwner {
        FacetCut[] memory facetCuts = new FacetCut[](2);
        facetCuts[0] = FacetCut(facetAddress, FacetCutAction.Add, _diamodSelectors());
        facetCuts[1] = FacetCut(address(this), FacetCutAction.Add, _erc165Selectors());
        diamondCut_(facetCuts, address(0), "");
    }

    function _diamodSelectors()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        bytes memory selectorsPtr = DIAMOND_SELECTORS;
        assembly {
            selectors := add(selectorsPtr, 0x20)
        }
    }

    function _erc165Selectors()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        bytes memory selectorsPtr = ERC165_SELECTORS;
        assembly {
            selectors := add(selectorsPtr, 0x20)
        }
    }
}
