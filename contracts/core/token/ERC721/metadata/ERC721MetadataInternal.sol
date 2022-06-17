// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { erc721MetadataStorage as es } from "./ERC721MetadataStorage.sol";

abstract contract ERC721MetadataInternal {
    function _name() internal view virtual returns (string memory) {
        return es().name;
    }

    function _symbol() internal view virtual returns (string memory) {
        return es().symbol;
    }

    function _tokenURI(uint256 tokenId) internal view virtual returns (string memory);
}