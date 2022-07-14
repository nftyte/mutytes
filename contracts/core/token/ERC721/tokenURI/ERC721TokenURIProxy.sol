// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721TokenURI } from "./IERC721TokenURI.sol";
import { ERC721TokenURIProxyController } from "./ERC721TokenURIProxyController.sol";
import { ProxyUpgradableController } from "../../../proxy/upgradable/ProxyUpgradableController.sol";

abstract contract ERC721TokenURIProxy is
    IERC721TokenURI,
    ERC721TokenURIProxyController,
    ProxyUpgradableController
{
    function tokenURI(uint256 tokenId)
        external
        virtual
        upgradable
        returns (string memory)
    {
        return tokenURIProxyable_(tokenId);
    }
}
