// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "./IERC165.sol";
import { ERC165Controller } from "./ERC165Controller.sol";
import { ProxyUpgradableController } from "../proxy/upgradable/ProxyUpgradableController.sol";

abstract contract ERC165Proxy is IERC165, ERC165Controller, ProxyUpgradableController {
    function supportsInterface(bytes4 interfaceId)
        external
        virtual
        upgradable
        returns (bool)
    {
        return supportsInterface_(interfaceId);
    }
}
