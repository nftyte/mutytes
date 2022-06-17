// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ProxyBase } from "./base/ProxyBase.sol";

abstract contract Proxy is ProxyBase {
    function _fallback() internal virtual {
        _delegate(_implementation());
    }

    fallback() external payable virtual {
        _fallback();
    }

    receive() external payable virtual {
        _fallback();
    }
}
