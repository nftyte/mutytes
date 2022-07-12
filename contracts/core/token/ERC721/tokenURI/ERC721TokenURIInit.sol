// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC721TokenURIModel } from "./ERC721TokenURIModel.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";

abstract contract ERC721TokenURIInit is ERC721TokenURIModel {
    using AddressUtils for address;

    constructor(address provider) {
        provider.enforceIsContract();
        _ERC721TokenURI(0, provider, false);
    }
}
