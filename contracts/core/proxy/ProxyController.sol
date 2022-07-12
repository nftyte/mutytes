// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ProxyModel } from "./ProxyModel.sol";
import { AddressUtils } from "../utils/AddressUtils.sol";

abstract contract ProxyController is ProxyModel {
    using AddressUtils for address;

    function fallback_() internal virtual {
        _delegate(implementation_());
    }

    function implementation_() internal view virtual returns (address implementation) {
        implementation = _implementation();
        implementation.enforceIsContract();
    }
}
