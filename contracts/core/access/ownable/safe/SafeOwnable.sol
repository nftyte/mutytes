// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ISafeOwnable } from "./ISafeOwnable.sol";
import { SafeOwnableController } from "./SafeOwnableController.sol";
import { Ownable, OwnableController } from "../Ownable.sol";

contract SafeOwnable is ISafeOwnable, Ownable, SafeOwnableController {
    function nomineeOwner() external view virtual returns (address) {
        return nomineeOwner_();
    }

    function acceptOwnership() external virtual {
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
