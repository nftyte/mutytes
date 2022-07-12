// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721MetadataModel } from "./ERC721MetadataModel.sol";

abstract contract ERC721MetadataController is ERC721MetadataModel {
    function name_() internal view virtual returns (string memory) {
        return _name();
    }

    function symbol_() internal view virtual returns (string memory) {
        return _symbol();
    }
}
