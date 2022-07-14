// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Controller } from "./IERC721Controller.sol";
import { ERC721BaseController } from "./base/ERC721BaseController.sol";
import { ERC721ApprovableController } from "./approvable/ERC721ApprovableController.sol";
import { ERC721TransferableController } from "./transferable/ERC721TransferableController.sol";

abstract contract ERC721Controller is
    IERC721Controller,
    ERC721BaseController,
    ERC721ApprovableController,
    ERC721TransferableController
{
    function IERC721_() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](9);
        bytes4[] memory base = IERC721Base_();
        bytes4[] memory approvable = IERC721Approvable_();
        bytes4[] memory transferable = IERC721Transferable_();
        (selectors[0], selectors[1]) = (base[0], base[1]);
        (selectors[2], selectors[3], selectors[4], selectors[5]) = (
            approvable[0],
            approvable[1],
            approvable[2],
            approvable[3]
        );
        (selectors[6], selectors[7], selectors[8]) = (
            transferable[0],
            transferable[1],
            transferable[2]
        );
    }
}
