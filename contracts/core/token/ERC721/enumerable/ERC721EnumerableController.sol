// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Enumerable } from "./IERC721Enumerable.sol";
import { ERC721EnumerableModel } from "./ERC721EnumerableModel.sol";
import { ERC721SupplyController } from "../supply/ERC721SupplyController.sol";
import { ERC721BaseController } from "../base/ERC721BaseController.sol";
import { IntegerUtils } from "../../../utils/IntegerUtils.sol";

abstract contract ERC721EnumerableController is
    ERC721EnumerableModel,
    ERC721SupplyController,
    ERC721BaseController
{
    using IntegerUtils for uint256;

    function IERC721Enumerable_()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](3);
        selectors[0] = IERC721Enumerable.totalSupply.selector;
        selectors[1] = IERC721Enumerable.tokenOfOwnerByIndex.selector;
        selectors[2] = IERC721Enumerable.tokenByIndex.selector;
    }

    function totalSupply_() internal view virtual returns (uint256) {
        return _maxSupply() - _availableSupply();
    }

    function tokenOfOwnerByIndex_(address owner, uint256 index)
        internal
        view
        virtual
        returns (uint256)
    {
        index.enforceLessThan(_balanceOf(owner));
        return _tokenOfOwnerByIndex_(owner, index);
    }

    function tokenByIndex_(uint256 index) internal view virtual returns (uint256) {
        index.enforceLessThan(totalSupply_());
        return _tokenByIndex_(index);
    }

    function _tokenOfOwnerByIndex_(address owner, uint256 index)
        internal
        view
        virtual
        returns (uint256 tokenId)
    {
        unchecked {
            index++;
            for (uint256 i; index > 0; i++) {
                if (_ownerOf(tokenId = _tokenByIndex(i)) == owner) {
                    index--;
                }
            }
        }
    }

    function _tokenByIndex_(uint256 index) internal view returns (uint256 tokenId) {
        unchecked {
            index++;
            for (uint256 i; index > 0; i++) {
                if (_tokenExists(tokenId = _tokenByIndex(i))) {
                    index--;
                }
            }
        }
    }
}
