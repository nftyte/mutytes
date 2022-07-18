// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721Base } from "./IERC721Base.sol";
import { ERC721BaseController } from "./ERC721BaseController.sol";
import { ProxyUpgradableController } from "../../../proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title ERC721 base implementation
 * @dev Note: Upgradable implementation
 */
abstract contract ERC721BaseProxy is
    IERC721Base,
    ERC721BaseController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IERC721Base
     */
    function balanceOf(address owner) external virtual upgradable returns (uint256) {
        return balanceOf_(owner);
    }

    /**
     * @inheritdoc IERC721Base
     */
    function ownerOf(uint256 tokenId) external virtual upgradable returns (address) {
        return ownerOf_(tokenId);
    }
}
