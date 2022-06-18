// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "./IERC165.sol";
import { ERC165Internal } from "./ERC165Internal.sol";

abstract contract ERC165 is IERC165, ERC165Internal {
    function supportsInterface(bytes4 interfaceId)
        external
        view
        virtual
        override
        returns (bool)
    {
        return _supportsInterface(interfaceId);
    }
}
