// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TokenURI } from "./IERC721TokenURI.sol";
import { ERC721TokenURIController } from "./ERC721TokenURIController.sol";

contract ERC721TokenURI is IERC721TokenURI, ERC721TokenURIController {
    function tokenURI(uint256 tokenId) external view virtual returns (string memory) {
        return tokenURI_(tokenId);
    }
}
