// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Base } from "./IERC721Base.sol";
import { ERC721BaseController } from "./ERC721BaseController.sol";
import { ProxyUpgradable } from "../../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC721BaseProxy is IERC721Base, ERC721BaseController, ProxyUpgradable {
    function balanceOf(address owner) external virtual upgradable returns (uint256) {
        return balanceOf_(owner);
    }

    function ownerOf(uint256 tokenId) external virtual upgradable returns (address) {
        return ownerOf_(tokenId);
    }
}
