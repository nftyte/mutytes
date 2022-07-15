// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IMutytesToken } from "./IMutytesToken.sol";

abstract contract MutytesTokenInit {
    function _IMutytesToken() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](1);
        selectors[0] = IMutytesToken.mintedSupply.selector;
    }
}
