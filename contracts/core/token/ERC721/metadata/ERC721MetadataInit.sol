// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721MetadataModel } from "./ERC721MetadataModel.sol";

abstract contract ERC721MetadataInit is ERC721MetadataModel {
    constructor(string memory name, string memory symbol) {
        _ERC721Metadata(name, symbol);
    }
}
