// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library ERC721TokenUtils {
    uint256 constant HOLDER_OFFSET = 8;
    uint256 constant POS_BITMASK = (1 << HOLDER_OFFSET) - 1; // 0xFF

    function toTokenId(address owner) internal pure returns (uint256) {
        return uint256(uint160(owner)) << HOLDER_OFFSET;
    }
    
    function index(uint256 tokenId) internal pure returns (uint256) {
        return tokenId & POS_BITMASK;
    }

    function holder(uint256 tokenId) internal pure returns (address) {
        return address(uint160(tokenId >> HOLDER_OFFSET));
    }
}