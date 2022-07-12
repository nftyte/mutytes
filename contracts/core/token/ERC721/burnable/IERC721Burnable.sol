// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BurnableController } from "./IERC721BurnableController.sol";

interface IERC721Burnable is IERC721BurnableController {
    function burn(uint256 tokenId) external;
}
