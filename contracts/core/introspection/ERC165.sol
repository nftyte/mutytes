// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC165 } from "./IERC165.sol";
import { ERC165Controller } from "./ERC165Controller.sol";

/**
 * @title ERC165 implementation
 */
contract ERC165 is IERC165, ERC165Controller {
    /**
     * @inheritdoc IERC165
     */
    function supportsInterface(bytes4 interfaceId) external view virtual returns (bool) {
        return supportsInterface_(interfaceId);
    }
}
