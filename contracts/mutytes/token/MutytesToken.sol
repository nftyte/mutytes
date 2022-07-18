// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IMutytesToken } from "./IMutytesToken.sol";
import { MutytesTokenController } from "./MutytesTokenController.sol";
import { ERC165 } from "../../core/introspection/ERC165.sol";
import { ERC721 } from "../../core/token/ERC721/ERC721.sol";
import { ERC721Metadata } from "../../core/token/ERC721/metadata/ERC721Metadata.sol";
import { ERC721Enumerable } from "../../core/token/ERC721/enumerable/ERC721Enumerable.sol";
import { ERC721Mintable } from "../../core/token/ERC721/mintable/ERC721Mintable.sol";
import { ERC721MintableController, ERC721MintableModel } from "../../core/token/ERC721/mintable/ERC721MintableController.sol";
import { ERC721Burnable, ERC721BurnableController } from "../../core/token/ERC721/burnable/ERC721Burnable.sol";

/**
 * @title Mutytes token implementation
 */
contract MutytesToken is
    IMutytesToken,
    ERC165,
    ERC721,
    ERC721Metadata,
    ERC721Enumerable,
    ERC721Mintable,
    ERC721Burnable,
    MutytesTokenController
{
    /**
     * @inheritdoc IMutytesToken
     */
    function availableSupply() external view virtual returns (uint256) {
        return _availableSupply();
    }

    function _burn_(address owner, uint256 tokenId)
        internal
        virtual
        override(ERC721BurnableController, MutytesTokenController)
    {
        super._burn_(owner, tokenId);
    }

    function _maxMintBalance()
        internal
        pure
        virtual
        override(ERC721MintableModel, MutytesTokenController)
        returns (uint256)
    {
        return super._maxMintBalance();
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
