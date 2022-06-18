// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { OwnableStorage } from "../OwnableStorage.sol";

library OwnableUtils {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function enforceIsContractOwner(OwnableStorage storage os) internal view {
        require(msg.sender == os.owner, "OwnableUtils: caller must be owner");
    }

    function transferOwnership(OwnableStorage storage os, address newOwner) internal {
        address owner = os.owner;
        os.owner = newOwner;
        emit OwnershipTransferred(owner, newOwner);
    }
}