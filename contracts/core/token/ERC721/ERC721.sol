// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";
import { ERC721Internal } from "./ERC721Internal.sol";
import { ERC165 } from "../../introspection/ERC165.sol";

abstract contract ERC721 is ERC721Internal, IERC721, ERC165 {
    function balanceOf(address owner)
        external
        view
        virtual
        override
        returns (uint256)
    {
        return _balanceOf(owner);
    }

    function ownerOf(uint256 tokenId)
        external
        view
        virtual
        override
        returns (address)
    {
        return _ownerOf(tokenId);
    }
    
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual override {
        _safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) external virtual override {
        _safeTransferFrom(from, to, tokenId, data);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual override {
        _transferFrom(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId)
        external
        virtual
        override
    {
        _approve(to, tokenId);
    }
    
    function getApproved(uint256 tokenId)
        external
        view
        virtual
        override
        returns (address)
    {
        return _getApproved(tokenId);
    }
    
    function setApprovalForAll(address operator, bool approved)
        external
        virtual
        override
    {
        _setApprovalForAll(operator, approved);
    }

    function isApprovedForAll(address owner, address operator)
        external
        view
        override
        virtual
        returns (bool)
    {
        return _isApprovedForAll(owner, operator);
    }
}