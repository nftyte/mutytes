// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC165Controller } from "../../core/introspection/ERC165Controller.sol";
import { OwnableController } from "../../core/access/ownable/OwnableController.sol";
import { ERC721TokenURIController } from "../../core/token/ERC721/tokenURI/ERC721TokenURIController.sol";
import { ERC721SupplyController } from "../../core/token/ERC721/supply/ERC721SupplyController.sol";
import { ProxyFacetedController } from "../../core/proxy/faceted/ProxyFacetedController.sol";

contract MutytesInitFacet is
    ERC165Controller,
    OwnableController,
    ERC721TokenURIController,
    ERC721SupplyController,
    ProxyFacetedController
{
    function setUpgradableFunctions(bytes4[] calldata selectors, bool isUpgradable)
        external
        virtual
        onlyOwner
    {
        unchecked {
            for (uint256 i; i < selectors.length; i++) {
                setIsUpgradable_(selectors[i], isUpgradable);
            }
        }
    }

    function setSupportedInterfaces(bytes4[] calldata interfaceIds, bool isSupported)
        external
        virtual
        onlyOwner
    {
        unchecked {
            for (uint256 i; i < interfaceIds.length; i++) {
                _setSupportedInterface(interfaceIds[i], isSupported);
            }
        }
    }

    function initTokenURI(
        uint256 id,
        address provider,
        bool isProxyable
    ) external virtual onlyOwner {
        ERC721TokenURI_(id, provider, isProxyable);
    }

    function initSupply(uint256 supply) external virtual onlyOwner {
        ERC721Supply_(supply);
    }
}
