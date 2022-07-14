// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Mintable } from "./IERC721Mintable.sol";
import { IERC721MintableController } from "./IERC721MintableController.sol";
import { ERC721MintableModel } from "./ERC721MintableModel.sol";
import { ERC721SupplyController } from "../supply/ERC721SupplyController.sol";
import { ERC721TokenUtils } from "../utils/ERC721TokenUtils.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";
import { IntegerUtils } from "../../../utils/IntegerUtils.sol";

abstract contract ERC721MintableController is
    IERC721MintableController,
    ERC721MintableModel,
    ERC721SupplyController
{
    using ERC721TokenUtils for address;
    using AddressUtils for address;
    using IntegerUtils for uint256;

    function IERC721Mintable_()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](1);
        selectors[0] = IERC721Mintable.mint.selector;
    }

    function mintedSupply_() internal view virtual returns (uint256) {
        return _initialSupply() - _availableSupply();
    }

    function mintBalanceOf_(address owner) internal view virtual returns (uint256) {
        owner.enforceIsNotZeroAddress();
        return _mintBalanceOf(owner);
    }

    function mint_(uint256 amount) internal virtual {
        _enforceCanMint(amount);
        (uint256 tokenId, uint256 maxTokenId) = _mint_(msg.sender, amount);

        unchecked {
            while (tokenId < maxTokenId) {
                emit Transfer(address(0), msg.sender, tokenId++);
            }
        }
    }

    function _mint_(address to, uint256 amount)
        internal
        virtual
        returns (uint256 tokenId, uint256 maxTokenId)
    {
        tokenId = to.toTokenId() | _mintBalanceOf(to);
        maxTokenId = tokenId + amount;
        _mint(to, amount);
        _updateAvailableSupply(amount);
    }

    function _enforceCanMint(uint256 amount) internal view virtual {
        amount.enforceIsNotZero();
        amount.enforceNotGreaterThan(_availableSupply());
        (_mintBalanceOf(msg.sender) + amount).enforceNotGreaterThan(_maxMintBalance());
    }
}
