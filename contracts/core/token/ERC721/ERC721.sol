// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";
import { ERC721Controller } from "./ERC721Controller.sol";

/**
 * @title ERC721 implementation, excluding optional extensions
 */
contract ERC721 is IERC721, ERC721Controller {
    /**
     * @inheritdoc IERC721
     */
    function balanceOf(address owner) external view virtual returns (uint256) {
        return balanceOf_(owner);
    }

    /**
     * @inheritdoc IERC721
     */
    function ownerOf(uint256 tokenId) external view virtual returns (address) {
        return ownerOf_(tokenId);
    }

    /**
     * @inheritdoc IERC721
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external virtual {
        safeTransferFrom_(from, to, tokenId, data);
    }

    /**
     * @inheritdoc IERC721
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual {
        safeTransferFrom_(from, to, tokenId, "");
    }

    /**
     * @inheritdoc IERC721
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual {
        transferFrom_(from, to, tokenId);
    }

    /**
     * @inheritdoc IERC721
     */
    function approve(address to, uint256 tokenId) external virtual {
        approve_(to, tokenId);
    }

    /**
     * @inheritdoc IERC721
     */
    function setApprovalForAll(address operator, bool approved) external virtual {
        setApprovalForAll_(operator, approved);
    }

    /**
     * @inheritdoc IERC721
     */
    function getApproved(uint256 tokenId) external view virtual returns (address) {
        return getApproved_(tokenId);
    }

    /**
     * @inheritdoc IERC721
     */
    function isApprovedForAll(address owner, address operator)
        external
        view
        virtual
        returns (bool)
    {
        return isApprovedForAll_(owner, operator);
    }
}
