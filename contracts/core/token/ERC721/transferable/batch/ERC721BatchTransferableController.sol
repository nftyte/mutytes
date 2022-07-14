// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721BatchTransferable } from "./IERC721BatchTransferable.sol";
import { ERC721TransferableController } from "../ERC721TransferableController.sol";
import { ERC721ReceiverUtils } from "../../utils/ERC721ReceiverUtils.sol";
import { AddressUtils } from "../../../../utils/AddressUtils.sol";

bytes4 constant SAFE_BATCH_TRANSFER_FROM_1_SELECTOR = bytes4(
    keccak256("safeBatchTransferFrom(address,address,uint256[],bytes)")
);
bytes4 constant SAFE_BATCH_TRANSFER_FROM_2_SELECTOR = bytes4(
    keccak256("safeBatchTransferFrom(address,address,uint256[])")
);

abstract contract ERC721BatchTransferableController is ERC721TransferableController {
    using ERC721ReceiverUtils for address;
    using AddressUtils for address;

    function IERC721BatchTransferable_()
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

    function safeBatchTransferFrom_(
        address from,
        address to,
        uint256[] memory tokenIds,
        bytes memory data
    ) internal virtual {
        if (to.isContract()) {
            to.enforceNotEquals(from);

            unchecked {
                for (uint256 i; i < tokenIds.length; i++) {
                    uint256 tokenId = tokenIds[i];
                    _enforceCanTransferFrom(from, to, tokenId);
                    _transferFrom_(from, to, tokenId);
                    to.enforceOnReceived(msg.sender, from, tokenId, data);
                }
            }
        } else {
            batchTransferFrom_(from, to, tokenIds);
        }
    }

    function batchTransferFrom_(
        address from,
        address to,
        uint256[] memory tokenIds
    ) internal virtual {
        to.enforceIsNotZeroAddress();
        to.enforceNotEquals(from);

        unchecked {
            for (uint256 i; i < tokenIds.length; i++) {
                uint256 tokenId = tokenIds[i];
                _enforceCanTransferFrom(from, to, tokenId);
                _transferFrom_(from, to, tokenId);
            }
        }
    }
}
