// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract InitializableProxy {
    constructor(address init, bytes memory data) {
        (bool success, ) = init.delegatecall(data);
        // todo require error msg
        require(success);
    }
}
