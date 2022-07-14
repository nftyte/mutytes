// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "./IERC165.sol";
import { ERC165Model } from "./ERC165Model.sol";

abstract contract ERC165Controller is ERC165Model {
    function IERC165_() internal pure virtual returns (bytes4[] memory selectors) {
        selectors = new bytes4[](1);
        selectors[0] = IERC165.supportsInterface.selector;
    }

    function supportsInterface_(bytes4 interfaceId) internal view virtual returns (bool) {
        return _supportsInterface(interfaceId);
    }
}
