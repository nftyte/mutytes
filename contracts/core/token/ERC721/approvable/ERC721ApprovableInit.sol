// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Approvable } from "./IERC721Approvable.sol";

abstract contract ERC721ApprovableInit {
    function _IERC721Approvable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](4);
        selectors[0] = IERC721Approvable.approve.selector;
        selectors[1] = IERC721Approvable.setApprovalForAll.selector;
        selectors[2] = IERC721Approvable.getApproved.selector;
        selectors[3] = IERC721Approvable.isApprovedForAll.selector;
    }
}
