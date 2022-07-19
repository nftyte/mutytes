// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { MutytesEnumerablePage } from "./MutytesEnumerablePage.sol";

/**
 * @title ERC721 enumerable page implementation
 * @dev Note: Test implementation
 */
contract MutytesEnumerablePage2 is MutytesEnumerablePage {
    function _bytecode() internal pure virtual override returns (bytes memory) {
        return
            hex"f39fd6e51aad88f6f4ce6ab8827279cfffb9226603f39fd6e51aad88f6f4ce6ab8827279cfffb92266043c44cdddb6a900fa2b585dd299e03d12fa4293bc003c44cdddb6a900fa2b585dd299e03d12fa4293bc013c44cdddb6a900fa2b585dd299e03d12fa4293bc023c44cdddb6a900fa2b585dd299e03d12fa4293bc03"; // 6 tokens
    }
}
