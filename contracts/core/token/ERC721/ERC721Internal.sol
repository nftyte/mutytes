// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { erc721Storage as es, ERC721Storage } from "./ERC721Storage.sol";

abstract contract ERC721Internal {
    function _balanceOf(address owner) internal view virtual returns (uint256) {
        return es().balanceOf(owner);
    }

    function _ownerOf(uint256 tokenId)
        internal
        view
        virtual
        returns (address owner)
    {
        owner = es().ownerOf(tokenId);
        
        require(
            owner != address(0),
            "ERC721Proxy: owner query for nonexistent token"
        );
    }
    
    function _safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        ERC721Storage storage erc721 = es();
        erc721.enforceIsApprovedOrOwner(msg.sender, tokenId);
        erc721.safeTransfer(from, to, tokenId, "");
    }

    function _safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal virtual {
        ERC721Storage storage erc721 = es();
        erc721.enforceIsApprovedOrOwner(msg.sender, tokenId);
        erc721.safeTransfer(from, to, tokenId, data);
    }

    function _transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        ERC721Storage storage erc721 = es();
        erc721.enforceIsApprovedOrOwner(msg.sender, tokenId);
        erc721.transfer(from, to, tokenId);
    }

    function _approve(address to, uint256 tokenId) internal virtual {
        ERC721Storage storage erc721 = es();
        address owner = erc721.ownerOf(tokenId);
        require(to != owner, "ERC721Proxy: approval to current owner");

        // TODO consider lib for msg.sender
        require(
            msg.sender == owner || erc721.isApprovedForAll(owner, msg.sender),
            "ERC721Proxy: approve caller is not owner nor approved for all"
        );

        erc721.approve(to, tokenId);
    }
    
    function _getApproved(uint256 tokenId)
        internal
        view
        virtual
        returns (address)
    {
        ERC721Storage storage erc721 = es();

        require(
            erc721.exists(tokenId),
            "ERC721Proxy: approved query for nonexistent token"
        );

        return erc721.getApproved(tokenId);
    }
    
    function _setApprovalForAll(address operator, bool approved)
        internal
        virtual
    {
        es().setApprovalForAll(msg.sender, operator, approved);
    }

    function _isApprovedForAll(address owner, address operator)
        internal
        view
        virtual
        returns (bool)
    {
        return es().isApprovedForAll(owner, operator);
    }
}