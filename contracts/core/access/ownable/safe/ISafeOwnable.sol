// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173 } from "../../IERC173.sol";
import { ISafeOwnableController } from "./ISafeOwnableController.sol";

interface ISafeOwnable is IERC173, ISafeOwnableController {
    function nomineeOwner() external returns (address);

    function acceptOwnership() external;
}
