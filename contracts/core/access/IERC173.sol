// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC173 /* is ERC165 */ {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function owner() external returns (address);

    function transferOwnership(address newOwner) external;
}
