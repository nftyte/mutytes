// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721SupplyModel } from "./ERC721SupplyModel.sol";
import { IntegerUtils } from "../../../utils/IntegerUtils.sol";

abstract contract ERC721SupplyInit is ERC721SupplyModel {
    using IntegerUtils for uint256;

    constructor(uint256 supply) {
        supply.enforceIsNotZero();
        _ERC721Supply(supply);
    }
}
