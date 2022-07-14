// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { MutytesTokenController } from "./MutytesTokenController.sol";
import { ERC165 } from "../../core/introspection/ERC165.sol";
import { ERC721 } from "../../core/token/ERC721/ERC721.sol";
import { ERC721Metadata } from "../../core/token/ERC721/metadata/ERC721Metadata.sol";
import { ERC721Enumerable } from "../../core/token/ERC721/enumerable/ERC721Enumerable.sol";
import { ERC721Mintable, ERC721MintableController } from "../../core/token/ERC721/mintable/ERC721Mintable.sol";
import { ERC721Burnable, ERC721BurnableController } from "../../core/token/ERC721/burnable/ERC721Burnable.sol";
import { ERC721BatchTransferable } from "../../core/token/ERC721/transferable/batch/ERC721BatchTransferable.sol";

contract MutytesToken is
    ERC165,
    ERC721,
    ERC721Metadata,
    ERC721Enumerable,
    ERC721Mintable,
    ERC721Burnable,
    ERC721BatchTransferable,
    MutytesTokenController
{
    function _burn_(address owner, uint256 tokenId)
        internal
        virtual
        override(ERC721BurnableController, MutytesTokenController)
    {
        super._burn_(owner, tokenId);
    }

    function _enforceCanMint(uint256 amount)
        internal
        view
        virtual
        override(ERC721MintableController, MutytesTokenController)
    {
        super._enforceCanMint(amount);
    }
}
