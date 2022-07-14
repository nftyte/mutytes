// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Base } from "./IERC721Base.sol";
import { IERC721BaseController } from "./IERC721BaseController.sol";
import { ERC721BaseModel } from "./ERC721BaseModel.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";

abstract contract ERC721BaseController is IERC721BaseController, ERC721BaseModel {
    using AddressUtils for address;

    function IERC721Base_() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](2);
        selectors[0] = IERC721Base.balanceOf.selector;
        selectors[1] = IERC721Base.ownerOf.selector;
    }

    function balanceOf_(address owner) internal view virtual returns (uint256) {
        owner.enforceIsNotZeroAddress();
        return _balanceOf(owner);
    }

    function ownerOf_(uint256 tokenId) internal view virtual returns (address owner) {
        owner = _ownerOf(tokenId);
        owner.enforceIsNotZeroAddress();
    }

    function _enforceTokenExists(uint256 tokenId) internal view virtual {
        if (!_tokenExists(tokenId)) {
            revert NonExistentToken(tokenId);
        }
    }
}
