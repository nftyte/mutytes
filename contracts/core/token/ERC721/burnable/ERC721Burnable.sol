// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721Burnable } from "./IERC721Burnable.sol";
import { ERC721BurnableController } from "./ERC721BurnableController.sol";

/**
 * @title ERC721 token burning extension implementation
 */
contract ERC721Burnable is IERC721Burnable, ERC721BurnableController {
    /**
     * @inheritdoc IERC721Burnable
     */
    function burn(uint256 tokenId) external virtual {
        burn_(tokenId);
    }
}
