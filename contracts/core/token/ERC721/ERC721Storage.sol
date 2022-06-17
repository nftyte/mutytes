// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC721Utils } from "./utils/ERC721Utils.sol";

using ERC721Utils for ERC721Storage global;

bytes32 constant ERC721_STORAGE_SLOT = keccak256("core.token.erc721.storage");

struct ERC721Storage {
    uint256 maxSupply;
    uint256 supply;
    uint256 burned;
    
    mapping(uint256 => address) owners;
    mapping(address => uint256) inventories;

    mapping(uint256 => address) tokenApprovals;
    mapping(address => mapping(address => bool)) operatorApprovals;
}

function erc721Storage() pure returns (ERC721Storage storage es) {
    bytes32 slot = ERC721_STORAGE_SLOT;
    assembly {
        es.slot := slot
    }
}
