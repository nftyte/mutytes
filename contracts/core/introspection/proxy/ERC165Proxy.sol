// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "../IERC165.sol";
import { ERC165Internal } from "../ERC165Internal.sol";
import { ProxyUpgradable } from "../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract ERC165Proxy is IERC165, ERC165Internal, ProxyUpgradable {
    function supportsInterface(bytes4 interfaceId)
        external
        virtual
        override
        upgradable
        returns (bool)
    {
        return _supportsInterface(interfaceId);
    }
}