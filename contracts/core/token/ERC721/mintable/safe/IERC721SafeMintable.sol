// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721MintableController } from "../IERC721Mintable.sol";

interface IERC721SafeMintable is IERC721MintableController {
    function safeMint(uint256 amount, bytes calldata data) external payable;
    
    function safeMint(uint256 amount) external payable;
}
