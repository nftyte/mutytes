// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721MintableController } from "../ERC721MintableController.sol";
import { ERC721ReceiverUtils } from "../../utils/ERC721ReceiverUtils.sol";
import { AddressUtils } from "../../../../utils/AddressUtils.sol";

abstract contract ERC721SafeMintableController is ERC721MintableController {
    using ERC721ReceiverUtils for address;
    using AddressUtils for address;

    function safeMint_(uint256 amount, bytes memory data) internal virtual {
        address to = msg.sender;

        if (to.isContract()) {
            _enforceCanMint(amount);
            (uint256 tokenId, uint256 maxTokenId) = _mint_(to, amount);

            unchecked {
                while (tokenId < maxTokenId) {
                    emit Transfer(address(0), to, tokenId);
                    to.enforceOnReceived(to, address(0), tokenId++, data);
                }
            }
        } else {
            mint_(amount);
        }
    }
}
