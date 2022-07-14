// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "./IERC721Metadata.sol";
import { IERC721MetadataController } from "./IERC721MetadataController.sol";
import { ERC721MetadataModel } from "./ERC721MetadataModel.sol";
import { ERC721TokenURIController } from "../tokenURI/ERC721TokenURIController.sol";

abstract contract ERC721MetadataController is
    IERC721MetadataController,
    ERC721MetadataModel,
    ERC721TokenURIController
{
    function IERC721Metadata_()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](3);
        selectors[0] = IERC721Metadata.name.selector;
        selectors[1] = IERC721Metadata.symbol.selector;
        selectors[2] = IERC721Metadata.tokenURI.selector;
    }

    function ERC721Metadata_(string memory name, string memory symbol) internal virtual {
        _setName(name);
        _setSymbol(symbol);
    }

    function name_() internal view virtual returns (string memory) {
        return _name();
    }

    function symbol_() internal view virtual returns (string memory) {
        return _symbol();
    }
}
