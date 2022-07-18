// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ISafeOwnable } from "./ISafeOwnable.sol";
import { SafeOwnableController } from "./SafeOwnableController.sol";
import { Ownable, IERC173 } from "../Ownable.sol";

/**
 * @title ERC173 safe ownership access control implementation
 */
contract SafeOwnable is ISafeOwnable, Ownable, SafeOwnableController {
    /**
     * @inheritdoc ISafeOwnable
     */
    function nomineeOwner() external view virtual returns (address) {
        return nomineeOwner_();
    }

    /**
     * @inheritdoc ISafeOwnable
     */
    function acceptOwnership() external virtual onlyNomineeOwner {
        acceptOwnership_();
    }
    
    /**
     * @inheritdoc IERC173
     */
    function transferOwnership(address newOwner)
        external
        virtual
        override(IERC173, Ownable)
        onlyOwner
    {
        _setNomineeOwner(newOwner);
    }
}
