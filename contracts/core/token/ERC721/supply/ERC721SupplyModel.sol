// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { erc721SupplyStorage as es } from "./ERC721SupplyStorage.sol";

abstract contract ERC721SupplyModel {
    function _initialSupply() internal view virtual returns (uint256) {
        return es().initial;
    }

    function _maxSupply() internal view virtual returns (uint256) {
        return es().max;
    }

    function _availableSupply() internal view virtual returns (uint256) {
        return es().available;
    }

    function _setInitialSupply(uint256 supply) internal virtual {
        es().initial = supply;
    }

    function _setMaxSupply(uint256 supply) internal virtual {
        es().max = supply;
    }

    function _setAvailableSupply(uint256 supply) internal virtual {
        es().available = supply;
    }

    function _updateMaxSupply(uint256 amount) internal virtual {
        es().max -= amount;
    }

    function _updateAvailableSupply(uint256 amount) internal virtual {
        es().available -= amount;
    }
}
