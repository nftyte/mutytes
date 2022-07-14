// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { DiamondInit } from "./DiamondInit.sol";
import { DiamondReadableController } from "./readable/DiamondReadableController.sol";
import { DiamondWritableController } from "./writable/DiamondWritableController.sol";

abstract contract DiamondController is
    DiamondInit,
    DiamondReadableController,
    DiamondWritableController
{}
