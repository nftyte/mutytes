// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC165Storage } from "../ERC165Storage.sol";

library ERC165Utils {
    function supportsInterface(ERC165Storage storage es, bytes4 interfaceId)
        internal
        view
        returns (bool)
    {
        return es.supportedInterfaces[interfaceId];
    }

    function setSupportedInterface(
        ERC165Storage storage es,
        bytes4 interfaceId,
        bool value
    ) internal {
        es.supportedInterfaces[interfaceId] = value;
    }
}