// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC173Controller {
    error ForbiddenOnlyOwner();

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
}
