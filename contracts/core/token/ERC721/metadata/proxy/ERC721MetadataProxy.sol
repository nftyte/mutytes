// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "../IERC721Metadata.sol";
import { ERC721MetadataInternal } from "../ERC721MetadataInternal.sol";
import { UpgradableProxy } from "../../../../proxy/upgradable/UpgradableProxy.sol";

abstract contract ERC721MetadataProxy is
    ERC721MetadataInternal,
    IERC721Metadata,
    UpgradableProxy
{
    function name() external virtual override upgradable returns (string memory) {
        return _name();
    }

    function symbol() external virtual override upgradable returns (string memory) {
        return _symbol();
    }

    function tokenURI(uint256 tokenId)
        external
        virtual
        override
        upgradable
        returns (string memory)
    {
        return _tokenURI(tokenId);
    }
}