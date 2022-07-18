// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC721SupplyModel } from "./ERC721SupplyModel.sol";

abstract contract ERC721SupplyController is ERC721SupplyModel {
    function ERC721Supply_(uint256 supply) internal virtual {
        _setInitialSupply(supply);
        _setMaxSupply(supply);
        _setAvailableSupply(supply);
    }
}
