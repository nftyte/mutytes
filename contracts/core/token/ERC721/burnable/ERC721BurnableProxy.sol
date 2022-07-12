// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Burnable } from "./IERC721Burnable.sol";
import { ERC721BurnableController } from "./ERC721BurnableController.sol";
import { ProxyUpgradable } from "../../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC721BurnableProxy is
    IERC721Burnable,
    ERC721BurnableController,
    ProxyUpgradable
{
    function burn(uint256 tokenId) external virtual override upgradable {
        burn_(tokenId);
    }
}
