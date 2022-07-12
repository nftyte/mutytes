// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173Controller } from "../../IERC173Controller.sol";

interface ISafeOwnableController is IERC173Controller {
    error ForbiddenOnlyNomineeOwner();
}
