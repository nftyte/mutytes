// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC721TokenURI } from "./IERC721TokenURI.sol";
import { ERC721TokenURIProxyController } from "./ERC721TokenURIProxyController.sol";
import { ProxyUpgradableController } from "../../../proxy/upgradable/ProxyUpgradableController.sol";

/**
 * @title ERC721 metadata extension token URI implementation
 * @dev Note: Upgradable implementation
 */
abstract contract ERC721TokenURIProxy is
    IERC721TokenURI,
    ERC721TokenURIProxyController,
    ProxyUpgradableController
{
    /**
     * @inheritdoc IERC721TokenURI
     */
    function tokenURI(uint256 tokenId)
        external
        virtual
        upgradable
        returns (string memory)
    {
        return tokenURIProxyable_(tokenId);
    }
}
