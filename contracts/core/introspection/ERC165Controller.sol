// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC165Model } from "./ERC165Model.sol";
import { ERC165Init } from "./ERC165Init.sol";

abstract contract ERC165Controller is ERC165Model, ERC165Init {
    function supportsInterface_(bytes4 interfaceId) internal view virtual returns (bool) {
        return _supportsInterface(interfaceId);
    }
}
