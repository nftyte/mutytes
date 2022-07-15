// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondWritable } from "./IDiamondWritable.sol";
import { DiamondWritableController } from "./DiamondWritableController.sol";

contract DiamondWritable is IDiamondWritable, DiamondWritableController {
    function diamondCut(
        FacetCut[] calldata facetCuts,
        address init,
        bytes calldata data
    ) external virtual {
        diamondCut_(facetCuts, init, data);
    }
}
