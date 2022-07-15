// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ISafeOwnable } from "./ISafeOwnable.sol";
import { SafeOwnableController } from "./SafeOwnableController.sol";
import { OwnableProxy, IERC173 } from "../OwnableProxy.sol";

abstract contract SafeOwnableProxy is ISafeOwnable, OwnableProxy, SafeOwnableController {
    function nomineeOwner() external virtual upgradable returns (address) {
        return nomineeOwner_();
    }

    function acceptOwnership() external virtual upgradable onlyNomineeOwner {
        acceptOwnership_();
    }

    function transferOwnership(address newOwner)
        external
        virtual
        override(IERC173, OwnableProxy)
        upgradable
        onlyOwner
    {
        _setNomineeOwner(newOwner);
    }
}
