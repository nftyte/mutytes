// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

bytes4 constant SAFE_MINT_1_SELECTOR = bytes4(keccak256("safeMint(uint256,bytes)"));
bytes4 constant SAFE_MINT_2_SELECTOR = bytes4(keccak256("safeMint(uint256)"));

abstract contract ERC721SafeMintableInit {
    function _IERC721SafeMintable()
        internal
        pure
        virtual
        returns (bytes4[] memory selectors)
    {
        selectors = new bytes4[](2);
        selectors[0] = SAFE_MINT_1_SELECTOR;
        selectors[1] = SAFE_MINT_2_SELECTOR;
    }
}
