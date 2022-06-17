// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Metadata } from "../IERC721Metadata.sol";
import { UpgradableProxy } from "../../../../proxy/upgradable/UpgradableProxy.sol";
import { erc721MetadataStorage as es, ERC721MetadataStorage } from "../ERC721MetadataStorage.sol";

abstract contract ERC721MetadataUpgradable is IERC721Metadata, UpgradableProxy {
    constructor(string memory name_, string memory symbol_) {
        ERC721MetadataStorage storage erc721Metadata = es();
        erc721Metadata.name = name_;
        erc721Metadata.symbol = symbol_;
    }

    function name() external virtual override upgradable returns (string memory) {
        return es().name;
    }

    function symbol() external virtual override upgradable returns (string memory) {
        return es().symbol;
    }
}