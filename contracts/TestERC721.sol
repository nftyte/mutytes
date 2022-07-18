// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC721Proxy } from "./core/token/ERC721/ERC721Proxy.sol";
import { ERC721MetadataProxy } from "./core/token/ERC721/metadata/ERC721MetadataProxy.sol";
import { ERC721EnumerableProxy } from "./core/token/ERC721/enumerable/ERC721EnumerableProxy.sol";
import { TestProxy } from "./TestProxy.sol";

contract TestERC721 is
    ERC721Proxy,
    ERC721MetadataProxy,
    ERC721EnumerableProxy,
    TestProxy
{
    constructor(address init, bytes memory data) TestProxy(init, data) {}
}
