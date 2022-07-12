// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BurnableController } from "./IERC721BurnableController.sol";
import { ERC721BurnableModel } from "./ERC721BurnableModel.sol";
import { ERC721SupplyModel } from "../supply/ERC721SupplyModel.sol";
import { ERC721ApprovableController } from "../approvable/ERC721ApprovableController.sol";

abstract contract ERC721BurnableController is
    IERC721BurnableController,
    ERC721BurnableModel,
    ERC721SupplyModel,
    ERC721ApprovableController
{
    function burn_(uint256 tokenId) internal virtual {
        address owner = _ownerOf(tokenId);
        _enforceIsApproved(owner, msg.sender, tokenId);
        _burn_(owner, tokenId);
    }

    function _burn_(address owner, uint256 tokenId) internal virtual {
        if (_getApproved(tokenId) != address(0)) {
            _approve_(owner, address(0), tokenId);
        }

        _burn(owner, tokenId);
        _updateMaxSupply(1);

        emit Transfer(owner, address(0), tokenId);
    }
}
