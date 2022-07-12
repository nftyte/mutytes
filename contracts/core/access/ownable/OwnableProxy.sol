// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173 } from "../IERC173.sol";
import { OwnableController } from "./OwnableController.sol";
import { ProxyUpgradable } from "../../proxy/upgradable/ProxyUpgradable.sol";

abstract contract OwnableProxy is IERC173, OwnableController, ProxyUpgradable {
    function owner() external virtual upgradable returns (address) {
        return owner_();
    }

    function transferOwnership(address newOwner) external virtual upgradable {
        transferOwnership_(newOwner);
    }
}