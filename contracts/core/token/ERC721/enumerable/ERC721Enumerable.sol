// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Enumerable } from "./IERC721Enumerable.sol";
import { ERC721EnumerableController } from "./ERC721EnumerableController.sol";

/**
 * @title ERC721 enumerable extension implementation
 */
contract ERC721Enumerable is IERC721Enumerable, ERC721EnumerableController {
    /**
     * @inheritdoc IERC721Enumerable
     */
    function totalSupply() external view virtual returns (uint256) {
        return totalSupply_();
    }

    /**
     * @inheritdoc IERC721Enumerable
     */
    function tokenByIndex(uint256 index) external view virtual returns (uint256) {
        return tokenByIndex_(index);
    }

    /**
     * @inheritdoc IERC721Enumerable
     */
    function tokenOfOwnerByIndex(address owner, uint256 index)
        external
        view
        virtual
        returns (uint256)
    {
        return tokenOfOwnerByIndex_(owner, index);
    }
}
