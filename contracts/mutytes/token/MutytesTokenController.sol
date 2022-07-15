// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { MutytesTokenInit } from "./MutytesTokenInit.sol";
import { ERC721TokenURIController } from "../../core/token/ERC721/tokenURI/ERC721TokenURIController.sol";
import { ERC721MintableController } from "../../core/token/ERC721/mintable/ERC721MintableController.sol";
import { ERC721BurnableController } from "../../core/token/ERC721/burnable/ERC721BurnableController.sol";
import { IntegerUtils } from "../../core/utils/IntegerUtils.sol";

abstract contract MutytesTokenController is
    MutytesTokenInit,
    ERC721BurnableController,
    ERC721MintableController,
    ERC721TokenURIController
{
    using IntegerUtils for uint256;

    function _burn_(address owner, uint256 tokenId) internal virtual override {
        if (_tokenURIProvider(tokenId) != 0) {
            _setTokenURIProvider(tokenId, 0);
        }

        super._burn_(owner, tokenId);
    }

    function _enforceCanMint(uint256 amount) internal view virtual override {
        msg.value.enforceIsZero();
        super._enforceCanMint(amount);
    }
}
