// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "../IERC165.sol";
import { UpgradableProxy } from "../../proxy/upgradable/UpgradableProxy.sol";
import { erc165Storage as es, ERC165Storage } from "../ERC165Storage.sol";

abstract contract ERC165Upgradable is IERC165, UpgradableProxy {
    function supportsInterface(bytes4 interfaceId)
        external
        virtual
        override
        upgradable
        returns (bool)
    {
        return es().supportsInterface(interfaceId);
    }
}