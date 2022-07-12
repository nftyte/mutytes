// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { MutytesTokenController } from "./MutytesTokenController.sol";
import { ERC165Proxy } from "../../core/introspection/ERC165Proxy.sol";
import { ERC721Proxy } from "../../core/token/ERC721/ERC721Proxy.sol";
import { ERC721MetadataProxy } from "../../core/token/ERC721/metadata/ERC721MetadataProxy.sol";
import { ERC721EnumerableProxy } from "../../core/token/ERC721/enumerable/ERC721EnumerableProxy.sol";
import { ERC721MintableProxy } from "../../core/token/ERC721/mintable/ERC721MintableProxy.sol";
import { ERC721BurnableProxy, ERC721BurnableController } from "../../core/token/ERC721/burnable/ERC721BurnableProxy.sol";
import { ERC721BatchTransferableProxy } from "../../core/token/ERC721/transferable/batch/ERC721BatchTransferableProxy.sol";

abstract contract MutytesTokenProxy is
    ERC165Proxy,
    ERC721Proxy,
    ERC721MetadataProxy,
    ERC721EnumerableProxy,
    ERC721MintableProxy,
    ERC721BurnableProxy,
    ERC721BatchTransferableProxy,
    MutytesTokenController
{
    function _burn_(address owner, uint256 tokenId)
        internal
        virtual
        override(ERC721BurnableController, MutytesTokenController)
    {
        super._burn_(owner, tokenId);
    }
}
