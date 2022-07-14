// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondReadableController } from "./readable/IDiamondReadableController.sol";
import { IDiamondWritableController } from "./writable/IDiamondWritableController.sol";

interface IDiamondController is IDiamondReadableController, IDiamondWritableController {}
