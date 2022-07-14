// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TokenURIController } from "./IERC721TokenURIController.sol";

interface IERC721TokenURI is IERC721TokenURIController {
    function tokenURI(uint256 tokenId) external returns (string memory);
}
