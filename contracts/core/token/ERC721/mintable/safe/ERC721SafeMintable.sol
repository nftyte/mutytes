// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721SafeMintable } from "./IERC721SafeMintable.sol";
import { ERC721SafeMintableController } from "./ERC721SafeMintableController.sol";

abstract contract ERC721SafeMintable is
    IERC721SafeMintable,
    ERC721SafeMintableController
{
    function safeMint(uint256 amount, bytes calldata data) external payable virtual {
        safeMint_(amount, data);
    }

    function safeMint(uint256 amount) external payable virtual {
        safeMint_(amount, "");
    }
}
