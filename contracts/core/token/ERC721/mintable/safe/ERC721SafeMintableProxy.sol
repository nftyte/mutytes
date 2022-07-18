// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721SafeMintable } from "./IERC721SafeMintable.sol";
import { ERC721SafeMintableController } from "./ERC721SafeMintableController.sol";
import { ProxyUpgradableController } from "../../../../proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title ERC721 safe mint extension implementation
 * @dev Note: Upgradable implementation
 */
abstract contract ERC721SafeMintableProxy is
    IERC721SafeMintable,
    ERC721SafeMintableController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IERC721SafeMintable
     */
    function safeMint(uint256 amount, bytes calldata data)
        external
        payable
        virtual
        upgradable
    {
        safeMint_(amount, data);
    }

    /**
     * @inheritdoc IERC721SafeMintable
     */
    function safeMint(uint256 amount) external payable virtual upgradable {
        safeMint_(amount, "");
    }
}
