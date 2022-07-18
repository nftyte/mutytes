// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TokenURI } from "./IERC721TokenURI.sol";
import { ERC721TokenURIController } from "./ERC721TokenURIController.sol";

/**
 * @title ERC721 metadata extension token URI implementation
 */
contract ERC721TokenURI is IERC721TokenURI, ERC721TokenURIController {
    /**
     * @inheritdoc IERC721TokenURI
     */
    function tokenURI(uint256 tokenId) external view virtual returns (string memory) {
        return tokenURI_(tokenId);
    }
}
