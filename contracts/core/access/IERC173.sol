// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC173Controller } from "./IERC173Controller.sol";

interface IERC173 is IERC173Controller {
    function owner() external returns (address);

    function transferOwnership(address newOwner) external;
}
