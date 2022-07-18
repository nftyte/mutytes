// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721MintableController } from "../IERC721Mintable.sol";

/**
 * @title ERC721 safe mint extension interface
 */
interface IERC721SafeMintable is IERC721MintableController {
    /**
     * @notice Mint new tokens
     * @dev Preforms ERC721Receiver check if applicable
     * @param amount The amount to mint
     * @param data Additional data
     */
    function safeMint(uint256 amount, bytes calldata data) external payable;

    /**
     * @notice Mint new tokens
     * @dev Preforms ERC721Receiver check if applicable
     * @param amount The amount to mint
     */
    function safeMint(uint256 amount) external payable;
}
