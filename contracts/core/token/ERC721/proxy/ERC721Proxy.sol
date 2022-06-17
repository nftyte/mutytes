// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "../IERC721.sol";
import { ERC721Internal } from "../ERC721Internal.sol";
import { UpgradableProxy } from "../../../proxy/upgradable/UpgradableProxy.sol";
import { erc721Storage as es, ERC721Storage } from "../ERC721Storage.sol";

abstract contract ERC721Proxy is ERC721Internal, IERC721, UpgradableProxy {
    function balanceOf(address owner)
        external
        virtual
        override
        upgradable
        returns (uint256)
    {
        return _balanceOf(owner);
    }

    function ownerOf(uint256 tokenId)
        external
        virtual
        override
        upgradable
        returns (address)
    {
        return _ownerOf(tokenId);
    }
    
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual override upgradable {
        _safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) external virtual override upgradable {
        _safeTransferFrom(from, to, tokenId, data);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual override upgradable {
        _transferFrom(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId)
        external
        virtual
        override
        upgradable
    {
        _approve(to, tokenId);
    }
    
    function getApproved(uint256 tokenId)
        external
        virtual
        override
        upgradable
        returns (address)
    {
        return _getApproved(tokenId);
    }
    
    function setApprovalForAll(address operator, bool approved)
        external
        virtual
        override
        upgradable
    {
        _setApprovalForAll(operator, approved);
    }

    function isApprovedForAll(address owner, address operator)
        external
        override
        virtual
        upgradable
        returns (bool)
    {
        return _isApprovedForAll(owner, operator);
    }
}