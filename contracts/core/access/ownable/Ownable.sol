// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173 } from "../IERC173.sol";
import { OwnableInternal } from "./OwnableInternal.sol";

abstract contract Ownable is IERC173, OwnableInternal {
    function owner() external view virtual override returns (address) {
        return _owner();
    }

    function transferOwnership(address newOwner) external virtual override {
        _transferOwnership(newOwner);
    }
}