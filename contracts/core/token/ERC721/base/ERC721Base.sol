// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Base } from "./IERC721Base.sol";
import { ERC721BaseController } from "./ERC721BaseController.sol";

/**
 * @title ERC721 base implementation
 */
contract ERC721Base is IERC721Base, ERC721BaseController {
    /**
     * @inheritdoc IERC721Base
     */
    function balanceOf(address owner) external view virtual returns (uint256) {
        return balanceOf_(owner);
    }

    /**
     * @inheritdoc IERC721Base
     */
    function ownerOf(uint256 tokenId) external view virtual returns (address) {
        return ownerOf_(tokenId);
    }
}
