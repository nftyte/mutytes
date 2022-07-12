// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { DiamondReadableProxy } from "./readable/DiamondReadableProxy.sol";
import { DiamondWritableProxy } from "./writable/DiamondWritableProxy.sol";

abstract contract DiamondProxy is DiamondReadableProxy, DiamondWritableProxy {}
