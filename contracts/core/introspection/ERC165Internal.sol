// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { erc165Storage as es } from "./ERC165Storage.sol";

abstract contract ERC165Internal {
    function _supportsInterface(bytes4 interfaceId)
        internal
        view
        virtual
        returns (bool)
    {
        return es().supportsInterface(interfaceId);
    }
}
