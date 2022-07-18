// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721BaseController } from "./IERC721BaseController.sol";

/**
 * @title ERC721 base interface
 */
interface IERC721Base is IERC721BaseController {
    /**
     * @notice Get the balance of an owner
     * @param owner The owner's address
     * @return balance The balance amount
     */
    function balanceOf(address owner) external returns (uint256);

    /**
     * @notice Get the owner a token
     * @param tokenId The token id
     * @return owner The owner's address
     */
    function ownerOf(uint256 tokenId) external returns (address);
}
