// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondController } from "./IDiamondController.sol";
import { IDiamondReadable } from "./readable/IDiamondReadable.sol";
import { IDiamondWritable } from "./writable/IDiamondWritable.sol";

interface IDiamond is IDiamondReadable, IDiamondWritable, IDiamondController {}
