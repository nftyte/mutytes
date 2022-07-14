// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Transferable } from "./IERC721Transferable.sol";
import { IERC721TransferableController } from "./IERC721TransferableController.sol";
import { ERC721TransferableModel } from "./ERC721TransferableModel.sol";
import { ERC721ApprovableController } from "../approvable/ERC721ApprovableController.sol";
import { ERC721ReceiverUtils } from "../utils/ERC721ReceiverUtils.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";

bytes4 constant SAFE_TRANSFER_FROM_1_SELECTOR = bytes4(
    keccak256("safeTransferFrom(address,address,uint256,bytes)")
);
bytes4 constant SAFE_TRANSFER_FROM_2_SELECTOR = bytes4(
    keccak256("safeTransferFrom(address,address,uint256)")
);

abstract contract ERC721TransferableController is
    IERC721TransferableController,
    ERC721TransferableModel,
    ERC721ApprovableController
{
    using ERC721ReceiverUtils for address;
    using AddressUtils for address;

    function IERC721Transferable_()
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

    function safeTransferFrom_(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal virtual {
        if (to.isContract()) {
            to.enforceNotEquals(from);
            _enforceCanTransferFrom(from, to, tokenId);
            _transferFrom_(from, to, tokenId);
            to.enforceOnReceived(msg.sender, from, tokenId, data);
        } else {
            transferFrom_(from, to, tokenId);
        }
    }

    function transferFrom_(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        to.enforceIsNotZeroAddress();
        to.enforceNotEquals(from);
        _enforceCanTransferFrom(from, to, tokenId);
        _transferFrom_(from, to, tokenId);
    }

    function _transferFrom_(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        if (_getApproved(tokenId) != address(0)) {
            _approve_(from, address(0), tokenId);
        }

        _transferFrom(from, to, tokenId);
        emit Transfer(from, to, tokenId);
    }

    function _enforceCanTransferFrom(
        address from,
        address,
        uint256 tokenId
    ) internal view virtual {
        from.enforceEquals(_ownerOf(tokenId));
        _enforceIsApproved(from, msg.sender, tokenId);
    }
}
