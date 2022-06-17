// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library AddressUtils {
    function hasContractCode(address account) internal view returns (bool) {
        return account.code.length > 0;
    }
}