// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Approvable } from "./IERC721Approvable.sol";
import { ERC721ApprovableController } from "./ERC721ApprovableController.sol";
import { ProxyUpgradable } from "../../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC721ApprovableProxy is
    IERC721Approvable,
    ERC721ApprovableController,
    ProxyUpgradable
{
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
