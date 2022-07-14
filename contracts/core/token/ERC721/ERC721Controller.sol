// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";
import { IERC721Controller } from "./IERC721Controller.sol";
import { ERC721BaseController } from "./base/ERC721BaseController.sol";
import { ERC721ApprovableController } from "./approvable/ERC721ApprovableController.sol";
import { ERC721TransferableController, SAFE_TRANSFER_FROM_1_SELECTOR, SAFE_TRANSFER_FROM_2_SELECTOR } from "./transferable/ERC721TransferableController.sol";

abstract contract ERC721Controller is
    IERC721Controller,
    ERC721BaseController,
    ERC721ApprovableController,
    ERC721TransferableController
{
    function IERC721_() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](9);
        selectors[0] = IERC721.balanceOf.selector;
        selectors[1] = IERC721.ownerOf.selector;
        selectors[2] = SAFE_TRANSFER_FROM_1_SELECTOR;
        selectors[3] = SAFE_TRANSFER_FROM_2_SELECTOR;
        selectors[4] = IERC721.transferFrom.selector;
        selectors[5] = IERC721.approve.selector;
        selectors[6] = IERC721.setApprovalForAll.selector;
        selectors[7] = IERC721.getApproved.selector;
        selectors[8] = IERC721.isApprovedForAll.selector;
    }
}
