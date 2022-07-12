// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ProxyModel } from "./ProxyModel.sol";
import { AddressUtils } from "../utils/AddressUtils.sol";
import { IntegerUtils } from "../utils/IntegerUtils.sol";

abstract contract ProxyInit is ProxyModel {
    using AddressUtils for address;
    using IntegerUtils for uint256;

    constructor(address init, bytes memory data) {
        init.enforceIsContract();
        data.length.enforceIsNotZero();
        _Proxy(init, data);
    }
}
