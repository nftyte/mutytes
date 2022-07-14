// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721MintableController } from "../ERC721MintableController.sol";
import { ERC721ReceiverUtils } from "../../utils/ERC721ReceiverUtils.sol";
import { AddressUtils } from "../../../../utils/AddressUtils.sol";

bytes4 constant SAFE_MINT_1_SELECTOR = bytes4(keccak256("safeMint(uint256,bytes)"));
bytes4 constant SAFE_MINT_2_SELECTOR = bytes4(keccak256("safeMint(uint256)"));

abstract contract ERC721SafeMintableController is ERC721MintableController {
    using ERC721ReceiverUtils for address;
    using AddressUtils for address;

    function IERC721SafeMintable_()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](2);
        selectors[0] = SAFE_MINT_1_SELECTOR;
        selectors[1] = SAFE_MINT_2_SELECTOR;
    }

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
