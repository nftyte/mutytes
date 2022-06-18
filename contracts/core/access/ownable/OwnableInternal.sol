// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ownableStorage as os, OwnableStorage } from "./OwnableStorage.sol";

abstract contract OwnableInternal {
    function _owner() internal view virtual returns (address) {
        return os().owner;
    }

    function _transferOwnership(address newOwner) internal virtual {
        OwnableStorage storage ownable = os();
        ownable.enforceIsContractOwner();
        ownable.transferOwnership(newOwner);
    }
}