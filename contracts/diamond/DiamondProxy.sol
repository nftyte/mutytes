// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IDiamond } from "./IDiamond.sol";
import { DiamondController } from "./DiamondController.sol";
import { DiamondReadableProxy } from "./readable/DiamondReadableProxy.sol";
import { DiamondWritableProxy } from "./writable/DiamondWritableProxy.sol";

/**
 * @title Diamond read and write operations implementation
 * @dev Note: Upgradable implementation
 */
abstract contract DiamondProxy is
    IDiamond,
    DiamondReadableProxy,
    DiamondWritableProxy,
    DiamondController
{}
