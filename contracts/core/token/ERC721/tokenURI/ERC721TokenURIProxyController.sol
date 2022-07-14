// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721TokenURIController } from "./ERC721TokenURIController.sol";
import { ProxyUpgradableController } from "../../../proxy/upgradable/ProxyUpgradableController.sol";

abstract contract ERC721TokenURIProxyController is
    ERC721TokenURIController,
    ProxyUpgradableController
{
    function tokenURIProxyable_(uint256 tokenId)
        internal
        virtual
        returns (string memory)
    {
        uint256 providerId = tokenURIProvider_(tokenId);
        (address provider, bool isProxyable) = _tokenURIProviderInfo(providerId);

        if (isProxyable) {
            _delegate(provider);
        } else {
            return _tokenURI(tokenId, provider);
        }
    }
}
