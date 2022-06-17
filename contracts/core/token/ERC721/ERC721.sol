// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "./IERC721.sol";
import { ERC165 } from "../../introspection/ERC165.sol";

abstract contract ERC721 is IERC721, ERC165 {
    function balanceOf(address owner)
        external
        view
        virtual
        override
        returns (uint256);

    function ownerOf(uint256 tokenId)
        external
        view
        virtual
        override
        returns (address);

    function getApproved(uint256 tokenId)
        external
        view
        virtual
        override
        returns (address);

    function isApprovedForAll(address owner, address operator)
        external
        view
        virtual
        override
        returns (bool);
}