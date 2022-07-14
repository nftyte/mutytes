// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ISafeOwnable } from "./ISafeOwnable.sol";
import { SafeOwnableModel } from "./SafeOwnableModel.sol";
import { OwnableController } from "../OwnableController.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";

abstract contract SafeOwnableController is SafeOwnableModel, OwnableController {
    using AddressUtils for address;

    function ISafeOwnable_() internal pure virtual returns (bytes4[] memory selectors) {
        bytes4[] memory ownable = IOwnable_();
        selectors = new bytes4[](4);
        (selectors[0], selectors[1]) = (ownable[0], ownable[1]);
        selectors[2] = ISafeOwnable.nomineeOwner.selector;
        selectors[3] = ISafeOwnable.acceptOwnership.selector;
    }

    function nomineeOwner_() internal view virtual returns (address) {
        return _nomineeOwner();
    }

    function transferOwnership_(address newOwner) internal virtual override {
        _enforceOnlyOwner();
        _setNomineeOwner(newOwner);
    }

    function acceptOwnership_() internal virtual {
        _enforceOnlyNomineeOwner();
        _transferOwnership_(_nomineeOwner());
        _setNomineeOwner(address(0));
    }

    function _enforceOnlyNomineeOwner() internal view virtual {
        msg.sender.enforceEquals(_nomineeOwner());
    }
}
