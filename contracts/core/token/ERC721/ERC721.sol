// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";
import { ERC721Controller } from "./ERC721Controller.sol";

abstract contract ERC721 is IERC721, ERC721Controller {
    function balanceOf(address owner) external view virtual returns (uint256) {
        return balanceOf_(owner);
    }

    function ownerOf(uint256 tokenId) external view virtual returns (address) {
        return ownerOf_(tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external virtual {
        safeTransferFrom_(from, to, tokenId, data);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual {
        safeTransferFrom_(from, to, tokenId, "");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual {
        transferFrom_(from, to, tokenId);
    }

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
