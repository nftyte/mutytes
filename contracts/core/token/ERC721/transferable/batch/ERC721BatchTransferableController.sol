// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC721TransferableController } from "../ERC721TransferableController.sol";
import { ERC721ReceiverUtils } from "../../utils/ERC721ReceiverUtils.sol";
import { AddressUtils } from "../../../../utils/AddressUtils.sol";

abstract contract ERC721BatchTransferableController is ERC721TransferableController {
    using ERC721ReceiverUtils for address;
    using AddressUtils for address;

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
