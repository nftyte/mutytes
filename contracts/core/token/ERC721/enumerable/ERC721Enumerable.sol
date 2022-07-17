// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Enumerable } from "./IERC721Enumerable.sol";
import { ERC721EnumerableController } from "./ERC721EnumerableController.sol";

contract ERC721Enumerable is IERC721Enumerable, ERC721EnumerableController {
    function totalSupply() external view virtual returns (uint256) {
        return totalSupply_();
    }

    function tokenByIndex(uint256 index) external view virtual returns (uint256) {
        return tokenByIndex_(index);
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        external
        view
        virtual
        returns (uint256)
    {
        return tokenOfOwnerByIndex_(owner, index);
    }
}
