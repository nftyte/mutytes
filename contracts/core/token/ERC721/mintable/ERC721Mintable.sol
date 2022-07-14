// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Mintable } from "./IERC721Mintable.sol";
import { ERC721MintableController } from "./ERC721MintableController.sol";

contract ERC721Mintable is IERC721Mintable, ERC721MintableController {
    function mint(uint256 amount) external payable virtual {
        mint_(amount);
    }
}
