// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ProxyInternal } from "../ProxyInternal.sol";
import { facetedProxyStorage as fps } from "./FacetedProxyStorage.sol";

abstract contract FacetedProxy is ProxyInternal {
    function _implementation() internal view virtual override returns (address) {
        return fps().selectorInfo[msg.sig].implementation;
    }
}
