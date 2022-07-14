// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";
import { ERC721Controller } from "./ERC721Controller.sol";
import { ProxyUpgradableController } from "../../proxy/upgradable/ProxyUpgradableController.sol";

abstract contract ERC721Proxy is IERC721, ERC721Controller, ProxyUpgradableController {
    function balanceOf(address owner) external virtual upgradable returns (uint256) {
        return balanceOf_(owner);
    }

    function ownerOf(uint256 tokenId) external virtual upgradable returns (address) {
        return ownerOf_(tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external virtual upgradable {
        safeTransferFrom_(from, to, tokenId, data);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual upgradable {
        safeTransferFrom_(from, to, tokenId, "");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external virtual upgradable {
        transferFrom_(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId) external virtual upgradable {
        approve_(to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved)
        external
        virtual
        upgradable
    {
        setApprovalForAll_(operator, approved);
    }

    function getApproved(uint256 tokenId) external virtual upgradable returns (address) {
        return getApproved_(tokenId);
    }

    function isApprovedForAll(address owner, address operator)
        external
        virtual
        upgradable
        returns (bool)
    {
        return isApprovedForAll_(owner, operator);
    }
}
