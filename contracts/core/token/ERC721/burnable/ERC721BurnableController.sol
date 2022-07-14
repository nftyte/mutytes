// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BurnableController } from "./IERC721BurnableController.sol";
import { ERC721BurnableModel } from "./ERC721BurnableModel.sol";
import { ERC721BurnableInit } from "./ERC721BurnableInit.sol";
import { ERC721SupplyController } from "../supply/ERC721SupplyController.sol";
import { ERC721ApprovableController } from "../approvable/ERC721ApprovableController.sol";

abstract contract ERC721BurnableController is
    IERC721BurnableController,
    ERC721BurnableModel,
    ERC721BurnableInit,
    ERC721SupplyController,
    ERC721ApprovableController
{
    function burnedSupply_() internal view virtual returns (uint256) {
        return _initialSupply() - _maxSupply();
    }

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
