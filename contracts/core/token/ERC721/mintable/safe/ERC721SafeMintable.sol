// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721SafeMintable } from "./IERC721SafeMintable.sol";
import { ERC721SafeMintableController } from "./ERC721SafeMintableController.sol";

/**
 * @title ERC721 safe mint extension implementation
 */
contract ERC721SafeMintable is IERC721SafeMintable, ERC721SafeMintableController {
    /**
     * @inheritdoc IERC721SafeMintable
     */
    function safeMint(uint256 amount, bytes calldata data) external payable virtual {
        safeMint_(amount, data);
    }

    /**
     * @inheritdoc IERC721SafeMintable
     */
    function safeMint(uint256 amount) external payable virtual {
        safeMint_(amount, "");
    }
}
