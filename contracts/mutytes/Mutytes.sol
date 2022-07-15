// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { MutytesToken } from "./token/MutytesToken.sol";
import { SafeOwnable } from "../core/access/ownable/safe/SafeOwnable.sol";

contract Mutytes is MutytesToken, SafeOwnable {
    constructor() {
        SafeOwnable_(msg.sender);
    }
}
