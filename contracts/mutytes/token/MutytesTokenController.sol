// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721TokenURIModel } from "../../core/token/ERC721/tokenURI/ERC721TokenURIModel.sol";
import { ERC721MintableController } from "../../core/token/ERC721/mintable/ERC721MintableController.sol";
import { ERC721BurnableController } from "../../core/token/ERC721/burnable/ERC721BurnableController.sol";
import { IntegerUtils } from "../../core/utils/IntegerUtils.sol";

abstract contract MutytesTokenController is
    ERC721TokenURIModel,
    ERC721MintableController,
    ERC721BurnableController
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
