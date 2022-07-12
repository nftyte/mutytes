// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BitMapUtils } from "../../../utils/BitMapUtils.sol";

library ERC721InventoryUtils {
    using BitMapUtils for uint256;

    uint256 constant BALANCE_BITSIZE = 16;
    uint256 constant BALANCE_BITMASK = (1 << BALANCE_BITSIZE) - 1; // 0xFFFF;
    uint256 constant CURRENT_SLOT_BITSIZE = 8;
    uint256 constant CURRENT_SLOT_BITMASK = (1 << CURRENT_SLOT_BITSIZE) - 1; // 0xFF;
    uint256 constant BITMAP_OFFSET = BALANCE_BITSIZE + CURRENT_SLOT_BITSIZE; // 24
    // uint256 constant BITMAP_BITMASK = ~((1 << BITMAP_OFFSET) - 1);
    uint256 constant SLOTS_PER_INVENTORY = 256 - BITMAP_OFFSET; // 232

    function balance(uint256 inventory) internal pure returns (uint256) {
        return inventory & BALANCE_BITMASK;
    }

    function current(uint256 inventory) internal pure returns (uint256) {
        return (inventory >> BALANCE_BITSIZE) & CURRENT_SLOT_BITMASK;
    }

    function has(uint256 inventory, uint256 index) internal pure returns (bool) {
        return inventory.isSet(BITMAP_OFFSET + index);
    }

    function add(uint256 inventory, uint256 amount) internal pure returns (uint256) {
        // uint256 offset = current(inventory);
        // require(amount + offset < SLOTS_PER_INVENTORY + 1, "ERC721Utils: add amount overflow");
        return
            inventory.setRange(BITMAP_OFFSET + current(inventory), amount) +
            (amount << BALANCE_BITSIZE) +
            amount;
    }

    function remove(uint256 inventory, uint256 index) internal pure returns (uint256) {
        return inventory.unset(BITMAP_OFFSET + index) - 1;
    }
}
