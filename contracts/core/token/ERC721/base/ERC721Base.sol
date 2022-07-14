// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Base } from "./IERC721Base.sol";
import { ERC721BaseController } from "./ERC721BaseController.sol";

contract ERC721Base is IERC721Base, ERC721BaseController {
    function balanceOf(address owner) external view virtual returns (uint256) {
        return balanceOf_(owner);
    }

    function ownerOf(uint256 tokenId) external view virtual returns (address) {
        return ownerOf_(tokenId);
    }
}
