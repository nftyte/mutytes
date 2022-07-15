// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173 } from "../IERC173.sol";
import { OwnableController } from "./OwnableController.sol";

contract Ownable is IERC173, OwnableController {
    function owner() external view virtual returns (address) {
        return owner_();
    }

    function transferOwnership(address newOwner) external virtual onlyOwner {
        transferOwnership_(newOwner);
    }
}
