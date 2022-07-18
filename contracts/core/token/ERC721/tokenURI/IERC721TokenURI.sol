// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TokenURIController } from "./IERC721TokenURIController.sol";

/**
 * @title ERC721 metadata extension token URI interface
 */
interface IERC721TokenURI is IERC721TokenURIController {
    /**
     * @notice Get the URI of a token
     * @param tokenId The token id
     * @return tokenURI The token URI
     */
    function tokenURI(uint256 tokenId) external returns (string memory);
}
