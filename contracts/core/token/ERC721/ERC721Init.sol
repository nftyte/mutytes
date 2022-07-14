// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";
import { SAFE_TRANSFER_FROM_1_SELECTOR, SAFE_TRANSFER_FROM_2_SELECTOR } from "./transferable/ERC721TransferableInit.sol";

abstract contract ERC721Init {
    function _IERC721() internal pure virtual returns (bytes4[] memory selectors) {
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
