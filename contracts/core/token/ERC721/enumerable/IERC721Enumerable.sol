// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721Enumerable {
    function totalSupply() external returns (uint256);

    function tokenByIndex(uint256 index) external returns (uint256);

    function tokenOfOwnerByIndex(address owner, uint256 index) external returns (uint256);
}
