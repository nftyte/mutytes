// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "../../core/introspection/IERC165.sol";
import { IERC721 } from "../../core/token/ERC721/IERC721.sol";
import { IERC721Metadata } from "../../core/token/ERC721/metadata/IERC721Metadata.sol";
import { IERC721Enumerable } from "../../core/token/ERC721/enumerable/IERC721Enumerable.sol";
import { IERC721Mintable } from "../../core/token/ERC721/mintable/IERC721Mintable.sol";
import { IERC721Burnable } from "../../core/token/ERC721/burnable/IERC721Burnable.sol";
import { IERC721BatchTransferable } from "../../core/token/ERC721/transferable/batch/IERC721BatchTransferable.sol";

interface IMutytesToken is
    IERC721BatchTransferable,
    IERC721Burnable,
    IERC721Mintable,
    IERC721Enumerable,
    IERC721Metadata,
    IERC721,
    IERC165
{
    function mintedSupply() external returns (uint256);
}