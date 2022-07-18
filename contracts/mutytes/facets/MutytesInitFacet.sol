// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC165Controller } from "../../core/introspection/ERC165Controller.sol";
import { OwnableController } from "../../core/access/ownable/OwnableController.sol";
import { ERC721TokenURIController } from "../../core/token/ERC721/tokenURI/ERC721TokenURIController.sol";
import { ERC721SupplyController } from "../../core/token/ERC721/supply/ERC721SupplyController.sol";
import { ProxyFacetedController } from "../../core/proxy/faceted/ProxyFacetedController.sol";

/**
 * @title Mutytes initialization facet
 */
contract MutytesInitFacet is
    ERC165Controller,
    OwnableController,
    ERC721TokenURIController,
    ERC721SupplyController,
    ProxyFacetedController
{
    /**
     * @notice Set upgradable functions and supported interfaces
     * @param selectors The upgradable function selectors
     * @param isUpgradable Whether the functions should be upgradable
     * @param interfaceIds The interface ids
     * @param isSupported Whether the interfaces should be supported
     */
    function setFunctionsAndInterfaces(
        bytes4[] calldata selectors,
        bool isUpgradable,
        bytes4[] calldata interfaceIds,
        bool isSupported
    ) external virtual onlyOwner {
        setUpgradableFunctions_(selectors, isUpgradable);
        _setSupportedInterfaces(interfaceIds, isSupported);
    }

    /**
     * @notice Set upgradable functions
     * @param selectors The upgradable function selectors
     * @param isUpgradable Whether the functions should be upgradable
     */
    function setUpgradableFunctions(bytes4[] calldata selectors, bool isUpgradable)
        external
        virtual
        onlyOwner
    {
        setUpgradableFunctions_(selectors, isUpgradable);
    }

    /**
     * @notice Set supported interfaces
     * @param interfaceIds The interface ids
     * @param isSupported Whether the interfaces should be supported
     */
    function setSupportedInterfaces(bytes4[] calldata interfaceIds, bool isSupported)
        external
        virtual
        onlyOwner
    {
        _setSupportedInterfaces(interfaceIds, isSupported);
    }

    /**
     * @notice Initialize the default token URI provider
     * @param id The URI provider id
     * @param provider The URI provider address
     * @param isProxyable Whether to proxy the URI provider
     */
    function initTokenURI(
        uint256 id,
        address provider,
        bool isProxyable
    ) external virtual onlyOwner {
        ERC721TokenURI_(id, provider, isProxyable);
    }

    /**
     * @notice Initialize the token supply
     * @param supply The initial supply amount
     */
    function initSupply(uint256 supply) external virtual onlyOwner {
        ERC721Supply_(supply);
    }
}
