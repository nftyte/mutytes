// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Enumerable } from "./IERC721Enumerable.sol";

abstract contract ERC721EnumerableInit {
    function _IERC721Enumerable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](3);
        selectors[0] = IERC721Enumerable.totalSupply.selector;
        selectors[1] = IERC721Enumerable.tokenOfOwnerByIndex.selector;
        selectors[2] = IERC721Enumerable.tokenByIndex.selector;
    }
}
