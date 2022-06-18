// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173 } from "../../IERC173.sol";
import { OwnableInternal } from "../OwnableInternal.sol";
import { UpgradableProxy } from "../../../proxy/upgradable/UpgradableProxy.sol";

abstract contract OwnableProxy is IERC173, OwnableInternal, UpgradableProxy {
    function owner() external virtual override upgradable returns (address) {
        return _owner();
    }

    function transferOwnership(address newOwner)
        external
        virtual
        override
        upgradable
    {
        _transferOwnership(newOwner);
    }
}