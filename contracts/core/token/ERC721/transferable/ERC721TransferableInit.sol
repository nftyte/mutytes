// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Transferable } from "./IERC721Transferable.sol";

bytes4 constant SAFE_TRANSFER_FROM_1_SELECTOR = bytes4(
    keccak256("safeTransferFrom(address,address,uint256,bytes)")
);
bytes4 constant SAFE_TRANSFER_FROM_2_SELECTOR = bytes4(
    keccak256("safeTransferFrom(address,address,uint256)")
);

abstract contract ERC721TransferableInit {
    function _IERC721Transferable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](3);
        selectors[0] = SAFE_TRANSFER_FROM_1_SELECTOR;
        selectors[1] = SAFE_TRANSFER_FROM_2_SELECTOR;
        selectors[2] = IERC721Transferable.transferFrom.selector;
    }
}
