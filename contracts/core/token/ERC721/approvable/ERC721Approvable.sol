// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Approvable } from "./IERC721Approvable.sol";
import { ERC721ApprovableController } from "./ERC721ApprovableController.sol";

contract ERC721Approvable is IERC721Approvable, ERC721ApprovableController {
    function approve(address to, uint256 tokenId) external virtual {
        approve_(to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) external virtual {
        setApprovalForAll_(operator, approved);
    }

    function getApproved(uint256 tokenId) external view virtual returns (address) {
        return getApproved_(tokenId);
    }

    function isApprovedForAll(address owner, address operator)
        external
        view
        virtual
        returns (bool)
    {
        return isApprovedForAll_(owner, operator);
    }
}
