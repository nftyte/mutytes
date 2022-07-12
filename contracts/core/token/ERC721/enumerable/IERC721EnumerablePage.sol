// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721EnumerablePage {
    function tokenByIndex(uint256 index) external view returns (uint256);
}
