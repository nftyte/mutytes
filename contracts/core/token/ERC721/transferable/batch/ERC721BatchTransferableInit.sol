// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BatchTransferable } from "./IERC721BatchTransferable.sol";

bytes4 constant SAFE_BATCH_TRANSFER_FROM_1_SELECTOR = bytes4(
    keccak256("safeBatchTransferFrom(address,address,uint256[],bytes)")
);
bytes4 constant SAFE_BATCH_TRANSFER_FROM_2_SELECTOR = bytes4(
    keccak256("safeBatchTransferFrom(address,address,uint256[])")
);

abstract contract ERC721BatchTransferableInit {
    function _IERC721BatchTransferable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](3);
        selectors[0] = SAFE_BATCH_TRANSFER_FROM_1_SELECTOR;
        selectors[1] = SAFE_BATCH_TRANSFER_FROM_2_SELECTOR;
        selectors[2] = IERC721BatchTransferable.batchTransferFrom.selector;
    }
}
