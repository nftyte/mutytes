// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721Metadata /* is IERC721 */ {
    function name() external returns (string memory);

    function symbol() external returns (string memory);

    function tokenURI(uint256 tokenId) external returns (string memory);
}