// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Approvable } from "./IERC721Approvable.sol";
import { ERC721ApprovableController } from "./ERC721ApprovableController.sol";
import { ProxyUpgradableController } from "../../../proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title ERC721 approvals implementation
 * @dev Note: Upgradable implementation
 */
abstract contract ERC721ApprovableProxy is
    IERC721Approvable,
    ERC721ApprovableController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IERC721Approvable
     */
    function approve(address to, uint256 tokenId) external virtual upgradable {
        approve_(to, tokenId);
    }

    /**
     * @inheritdoc IERC721Approvable
     */
    function setApprovalForAll(address operator, bool approved)
        external
        virtual
        upgradable
    {
        setApprovalForAll_(operator, approved);
    }

    /**
     * @inheritdoc IERC721Approvable
     */
    function getApproved(uint256 tokenId) external virtual upgradable returns (address) {
        return getApproved_(tokenId);
    }

    /**
     * @inheritdoc IERC721Approvable
     */
    function isApprovedForAll(address owner, address operator)
        external
        virtual
        upgradable
        returns (bool)
    {
        return isApprovedForAll_(owner, operator);
    }
}
