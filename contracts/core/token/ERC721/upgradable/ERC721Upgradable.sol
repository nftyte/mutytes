// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "../IERC721.sol";
import { UpgradableProxy } from "../../../proxy/upgradable/UpgradableProxy.sol";
import { erc721Storage as es, ERC721Storage } from "../ERC721Storage.sol";

abstract contract ERC721Upgradable is IERC721, UpgradableProxy {
    function balanceOf(address owner)
        external
        virtual
        override
        upgradable
        returns (uint256)
    {
        return es().balanceOf(owner);
    }

    function ownerOf(uint256 tokenId)
        external
        virtual
        override
        upgradable
        returns (address owner)
    {
        owner = es().ownerOf(tokenId);
        
        require(
            owner != address(0),
            "ERC721: owner query for nonexistent token"
        );
    }
    
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual override upgradable {
        ERC721Storage storage erc721 = es();
        erc721.enforceIsApprovedOrOwner(msg.sender, tokenId);
        erc721.safeTransfer(from, to, tokenId, "");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) external virtual override upgradable {
        ERC721Storage storage erc721 = es();
        erc721.enforceIsApprovedOrOwner(msg.sender, tokenId);
        erc721.safeTransfer(from, to, tokenId, data);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual override upgradable {
        ERC721Storage storage erc721 = es();
        erc721.enforceIsApprovedOrOwner(msg.sender, tokenId);
        erc721.transfer(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId)
        external
        virtual
        override
        upgradable
    {
        ERC721Storage storage erc721 = es();
        address owner = erc721.ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        // TODO consider lib for msg.sender
        require(
            msg.sender == owner || erc721.isApprovedForAll(owner, msg.sender),
            "ERC721: approve caller is not owner nor approved for all"
        );

        erc721.approve(to, tokenId);
    }
    
    function getApproved(uint256 tokenId)
        external
        virtual
        override
        upgradable
        returns (address)
    {
        ERC721Storage storage erc721 = es();

        require(
            erc721.exists(tokenId),
            "ERC721: approved query for nonexistent token"
        );

        return erc721.getApproved(tokenId);
    }
    
    function setApprovalForAll(address operator, bool approved)
        external
        virtual
        override
        upgradable
    {
        es().setApprovalForAll(msg.sender, operator, approved);
    }

    function isApprovedForAll(address owner, address operator)
        external
        override
        virtual
        upgradable
        returns (bool)
    {
        return es().isApprovedForAll(owner, operator);
    }
}