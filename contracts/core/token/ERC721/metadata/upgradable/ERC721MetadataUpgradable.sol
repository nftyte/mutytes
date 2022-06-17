// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721MetadataUpgradable as IERC721Metadata } from "./IERC721MetadataUpgradable.sol";
import { UpgradableProxy } from "../../../../proxy/upgradable/UpgradableProxy.sol";
import { erc721MetadataStorage as es } from "../ERC721MetadataStorage.sol";

abstract contract ERC721MetadataUpgradable is IERC721Metadata, UpgradableProxy {
    function name() external virtual override upgradable returns (string memory) {
        return es().name;
    }

    function symbol() external virtual override upgradable returns (string memory) {
        return es().symbol;
    }
}