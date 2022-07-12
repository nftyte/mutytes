// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Enumerable } from "./IERC721Enumerable.sol";
import { ERC721EnumerableController } from "./ERC721EnumerableController.sol";
import { ProxyUpgradable } from "../../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC721EnumerableProxy is
    IERC721Enumerable,
    ERC721EnumerableController,
    ProxyUpgradable
{
    function totalSupply() external virtual upgradable returns (uint256) {
        return totalSupply_();
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        external
        virtual
        upgradable
        returns (uint256)
    {
        return tokenOfOwnerByIndex_(owner, index);
    }

    function tokenByIndex(uint256 index) external virtual upgradable returns (uint256) {
        return tokenByIndex_(index);
    }
}
