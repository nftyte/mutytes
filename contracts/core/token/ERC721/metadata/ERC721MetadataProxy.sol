// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "./IERC721Metadata.sol";
import { ERC721MetadataController } from "./ERC721MetadataController.sol";
import { ERC721TokenURIProxyController } from "../tokenURI/ERC721TokenURIProxyController.sol";

abstract contract ERC721MetadataProxy is
    IERC721Metadata,
    ERC721MetadataController,
    ERC721TokenURIProxyController
{
    function name() external virtual upgradable returns (string memory) {
        return name_();
    }

    function symbol() external virtual upgradable returns (string memory) {
        return symbol_();
    }

    function tokenURI(uint256 tokenId)
        external
        virtual
        upgradable
        returns (string memory)
    {
        return tokenURIProxyable_(tokenId);
    }
}
