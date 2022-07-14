// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721SafeMintable } from "./IERC721SafeMintable.sol";
import { ERC721SafeMintableController } from "./ERC721SafeMintableController.sol";
import { ProxyUpgradable } from "../../../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC721SafeMintableProxy is
    IERC721SafeMintable,
    ERC721SafeMintableController,
    ProxyUpgradable
{
    function safeMint(uint256 amount, bytes calldata data)
        external
        payable
        virtual
        upgradable
    {
        safeMint_(amount, data);
    }

    function safeMint(uint256 amount) external payable virtual upgradable {
        safeMint_(amount, "");
    }
}
