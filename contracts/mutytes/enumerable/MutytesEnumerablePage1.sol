// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { MutytesEnumerablePage } from "./MutytesEnumerablePage.sol";

/**
 * @title ERC721 enumerable page implementation
 * @dev Note: Test implementation
 */
contract MutytesEnumerablePage1 is MutytesEnumerablePage {
    function _bytecode() internal view virtual override returns (bytes memory) {
        return
            hex"f39fd6e51aad88f6f4ce6ab8827279cfffb9226600f39fd6e51aad88f6f4ce6ab8827279cfffb9226601f39fd6e51aad88f6f4ce6ab8827279cfffb922660270997970c51812dc3a010c7d01b50e0d17dc79c80070997970c51812dc3a010c7d01b50e0d17dc79c80170997970c51812dc3a010c7d01b50e0d17dc79c80270997970c51812dc3a010c7d01b50e0d17dc79c803"; // 7 tokens
    }
}
