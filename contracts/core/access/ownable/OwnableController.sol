// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173Controller } from "../IERC173Controller.sol";
import { OwnableModel } from "./OwnableModel.sol";

abstract contract OwnableController is IERC173Controller, OwnableModel {
    modifier onlyOwner() {
        _enforceOnlyOwner();
        _;
    }

    function owner_() internal view virtual returns (address) {
        return _owner();
    }

    function transferOwnership_(address newOwner) internal virtual {
        _enforceOnlyOwner();
        _transferOwnership_(newOwner);
    }

    function _transferOwnership_(address newOwner) internal virtual {
        _transferOwnership(newOwner);
        emit OwnershipTransferred(_owner(), newOwner);
    }

    function _enforceOnlyOwner() internal view virtual {
        if (msg.sender == _owner()) {
            return;
        }

        revert ForbiddenOnlyOwner();
    }
}
