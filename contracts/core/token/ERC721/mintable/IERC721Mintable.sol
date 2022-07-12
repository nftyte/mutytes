// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721MintableController } from "./IERC721MintableController.sol";

interface IERC721Mintable is IERC721MintableController {
    function mint(uint256 amount) external payable;
}
