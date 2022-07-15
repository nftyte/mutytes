// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ISafeOwnable } from "./ISafeOwnable.sol";
import { SafeOwnableController } from "./SafeOwnableController.sol";
import { Ownable, IERC173 } from "../Ownable.sol";

contract SafeOwnable is ISafeOwnable, Ownable, SafeOwnableController {
    function nomineeOwner() external view virtual returns (address) {
        return nomineeOwner_();
    }

    function acceptOwnership() external virtual onlyNomineeOwner {
        acceptOwnership_();
    }

    function transferOwnership(address newOwner)
        external
        virtual
        override(IERC173, Ownable)
        onlyOwner
    {
        _setNomineeOwner(newOwner);
    }
}
