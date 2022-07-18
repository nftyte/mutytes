// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { MutytesToken } from "./token/MutytesToken.sol";
import { SafeOwnable } from "../core/access/ownable/safe/SafeOwnable.sol";

/**
 * @title Mutytes proxy API implementation
 */
abstract contract MutytesAPI is MutytesToken, SafeOwnable {
    constructor() {
        MutytesToken_();
        Ownable_();
    }
}
