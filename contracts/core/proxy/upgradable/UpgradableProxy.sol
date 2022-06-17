// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ProxyBase } from "../base/ProxyBase.sol";

abstract contract UpgradableProxy is ProxyBase {
    modifier upgradable() {
        address implementation = _implementation();
        
         if (implementation == address(this)) {
            _;
        } else if (implementation == address(0)) {
            // todo revert error msg
            revert();
        } else {
            _delegate(implementation);
        }
    }
}
