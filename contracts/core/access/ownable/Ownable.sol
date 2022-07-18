// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173 } from "../IERC173.sol";
import { OwnableController } from "./OwnableController.sol";

/**
 * @title ERC173 ownership access control implementation
 */
contract Ownable is IERC173, OwnableController {
    /**
     * @inheritdoc IERC173
     */
    function owner() external view virtual returns (address) {
        return owner_();
    }

    /**
     * @inheritdoc IERC173
     */
    function transferOwnership(address newOwner) external virtual onlyOwner {
        transferOwnership_(newOwner);
    }
}
