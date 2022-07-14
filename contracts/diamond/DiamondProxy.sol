// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamond } from "./IDiamond.sol";
import { DiamondController } from "./DiamondController.sol";
import { DiamondReadableProxy } from "./readable/DiamondReadableProxy.sol";
import { DiamondWritableProxy } from "./writable/DiamondWritableProxy.sol";

abstract contract DiamondProxy is
    IDiamond,
    DiamondReadableProxy,
    DiamondWritableProxy,
    DiamondController
{}
