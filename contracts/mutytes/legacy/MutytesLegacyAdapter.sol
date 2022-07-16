// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IMutytesLegacyProvider } from "./IMutytesLegacyProvider.sol";
import { IERC721TokenURIProvider } from "../../core/token/ERC721/tokenURI/IERC721TokenURIProvider.sol";

contract MutytesLegacyAdapter is IERC721TokenURIProvider {
    address _interpreterAddress;
    string _externalURL;

    constructor(address interpreterAddress, string memory externalURL) {
        _interpreterAddress = interpreterAddress;
        _externalURL = externalURL;
    }

    function tokenURI(uint256 tokenId) external view virtual returns (string memory) {
        IMutytesLegacyProvider interpreter = IMutytesLegacyProvider(_interpreterAddress);
        IMutytesLegacyProvider.TokenData memory token;
        token.id = tokenId;
        token.dna = new uint256[](1);
        token.dna[0] = uint256(keccak256(abi.encode(tokenId)));
        IMutytesLegacyProvider.MutationData memory mutation;
        mutation.count = 1;
        return interpreter.tokenURI(token, mutation, _externalURL);
    }
}