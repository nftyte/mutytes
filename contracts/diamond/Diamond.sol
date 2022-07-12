// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { DiamondReadable } from "./readable/DiamondReadable.sol";
import { DiamondWritable } from "./writable/DiamondWritable.sol";

abstract contract Diamond is DiamondReadable, DiamondWritable {}
