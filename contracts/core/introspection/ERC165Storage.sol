// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC165Utils } from "./utils/ERC165Utils.sol";

using ERC165Utils for ERC165Storage global;

bytes32 constant ERC165_STORAGE_SLOT = keccak256("core.introspection.erc165.storage");

struct ERC165Storage {
    mapping(bytes4 => bool) supportedInterfaces;
}

function erc165Storage() pure returns (ERC165Storage storage es) {
    bytes32 slot = ERC165_STORAGE_SLOT;
    assembly {
        es.slot := slot
    }
}
