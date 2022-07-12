// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ISafeOwnable } from "./ISafeOwnable.sol";
import { SafeOwnableController } from "./SafeOwnableController.sol";
import { OwnableProxy, OwnableController } from "../OwnableProxy.sol";

abstract contract SafeOwnableProxy is ISafeOwnable, OwnableProxy, SafeOwnableController {
    function nomineeOwner() external virtual upgradable returns (address) {
        return nomineeOwner_();
    }

    function acceptOwnership() external virtual upgradable {
        acceptOwnership_();
    }

    function transferOwnership_(address newOwner)
        internal
        virtual
        override(OwnableController, SafeOwnableController)
    {
        super.transferOwnership_(newOwner);
    }
}
