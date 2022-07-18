// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Mintable } from "./IERC721Mintable.sol";
import { ERC721MintableController } from "./ERC721MintableController.sol";

/**
 * @title ERC721 token minting extension implementation
 */
contract ERC721Mintable is IERC721Mintable, ERC721MintableController {
    /**
     * @inheritdoc IERC721Mintable
     */
    function mint(uint256 amount) external payable virtual {
        mint_(amount);
    }
}
