// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Diamond } from "../../diamond/Diamond.sol";
import { IDiamondWritable } from "../../diamond/writable/IDiamondWritable.sol";

bytes constant SELECTORS_BYTECODE = abi.encode(
    2,
    IDiamondWritable.diamondCut.selector,
    MutytesDiamondFacet.diamondCut.selector
);

contract MutytesDiamondFacet is Diamond {
    function init(address diamondAddress) external virtual {
        FacetCut[] memory facetCuts = new FacetCut[](1);
        facetCuts[0] = FacetCut(diamondAddress, FacetCutAction.Add, _selectors());
        diamondCut_(facetCuts, address(0), "", false);
    }

    function diamondCut(
        FacetCut[] calldata facetCuts,
        address initAddress,
        bytes calldata data,
        bool isUpgradable
    ) external virtual {
        diamondCut_(facetCuts, initAddress, data, isUpgradable);
    }

    function _selectors() internal view virtual returns (bytes4[] memory selectors) {
        bytes memory selectorsPtr = SELECTORS_BYTECODE;

        assembly {
            selectors := add(selectorsPtr, 0x20)
        }
    }
}
