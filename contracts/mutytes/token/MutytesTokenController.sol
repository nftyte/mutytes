// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721TokenURIModel } from "../../core/token/ERC721/tokenURI/ERC721TokenURIModel.sol";
import { ERC721BurnableController } from "../../core/token/ERC721/burnable/ERC721BurnableController.sol";

abstract contract MutytesTokenController is
    ERC721TokenURIModel,
    ERC721BurnableController
{
    function _burn_(address owner, uint256 tokenId) internal virtual override {
        if (_tokenURIProvider(tokenId) != 0) {
            _setTokenURIProvider(tokenId, 0);
        }

        super._burn_(owner, tokenId);
    }
}
