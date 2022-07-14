// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondController } from "./IDiamondController.sol";
import { DiamondReadableController } from "./readable/DiamondReadableController.sol";
import { DiamondWritableController } from "./writable/DiamondWritableController.sol";

abstract contract DiamondController is
    IDiamondController,
    DiamondReadableController,
    DiamondWritableController
{
    function IDiamond_() internal pure virtual returns (bytes4[] memory selectors) {
        bytes4[] memory readable = IDiamondReadable_();
        bytes4[] memory writable = IDiamondWritable_();
        selectors = new bytes4[](5);
        (selectors[0], selectors[1], selectors[2], selectors[3]) = (
            readable[0],
            readable[1],
            readable[2],
            readable[3]
        );
        selectors[4] = writable[0];
    }
}
