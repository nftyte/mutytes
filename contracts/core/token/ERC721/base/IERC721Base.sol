// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BaseController } from "./IERC721BaseController.sol";

interface IERC721Base is IERC721BaseController {
    function balanceOf(address owner) external returns (uint256);

    function ownerOf(uint256 tokenId) external returns (address);
}
