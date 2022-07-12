// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Mintable } from "./IERC721Mintable.sol";
import { ERC721MintableController } from "./ERC721MintableController.sol";
import { ProxyUpgradable } from "../../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC721MintableProxy is
    IERC721Mintable,
    ERC721MintableController,
    ProxyUpgradable
{
    function mint(uint256 amount) external payable virtual override upgradable {
        mint_(amount);
    }
}
