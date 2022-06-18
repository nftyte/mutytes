// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC721Storage } from "../ERC721Storage.sol";
import { IERC721Receiver } from "../IERC721Receiver.sol";
import { ERC721TokenUtils } from "./ERC721TokenUtils.sol";
import { ERC721InventoryUtils } from "./ERC721InventoryUtils.sol";
import { AddressUtils } from "../../../utils/AddressUtils.sol";

library ERC721Utils {
    using AddressUtils for address;
    using ERC721TokenUtils for address;
    using ERC721TokenUtils for uint256;
    using ERC721InventoryUtils for uint256;

    function balanceOf(ERC721Storage storage es, address owner) internal view returns (uint256) {
        return es.inventories[owner].balance();
    }
    
    function mintBalanceOf(ERC721Storage storage es, address owner) internal view returns (uint256) {
        return es.inventories[owner].minted();
    }

    function ownerOf(ERC721Storage storage es, uint256 tokenId) internal view returns (address owner) {
        owner = es.owners[tokenId];

        if (owner == address(0)) {
            address holder = tokenId.holder();
            if (es.inventories[holder].has(tokenId.index())) {
                owner = holder;
            }
        }
    }

    function exists(ERC721Storage storage es, uint256 tokenId) internal view returns (bool) {
        if (es.owners[tokenId] == address(0)) {
            return es.inventories[tokenId.holder()].has(tokenId.index());
        }
        
        return true;
    }

    function totalSupply(ERC721Storage storage es) internal view returns (uint256) {
        // TODO add unchecked
        return es.maxSupply - es.supply - es.burned;
    }

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function safeTransfer(
        ERC721Storage storage es,
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal {
        transfer(es, from, to, tokenId);

        if (to.hasContractCode()) {
            require(
                _checkOnERC721Received(from, to, tokenId, data),
                "ERC721Utils: transfer to non-ERC721Receiver implementer"
            );
        }
    }

    function transfer(
        ERC721Storage storage es,
        address from,
        address to,
        uint256 tokenId
    ) internal {
        require(
            ownerOf(es, tokenId) == from,
            "ERC721Utils: transfer from incorrect owner"
        );
        require(to != address(0), "ERC721Utils: transfer to the zero address");

        // Clear approvals from the previous owner
        approve(es, address(0), tokenId);

        if (es.owners[tokenId] == from) {
            es.inventories[from]--;
        } else {
            es.inventories[from] = es.inventories[from].remove(tokenId.index());
        }

        es.owners[tokenId] = to;

        unchecked {
            es.inventories[to]++;
        }

        emit Transfer(from, to, tokenId);
    }

    function safeMint(
        ERC721Storage storage es,
        address to,
        uint256 amount,
        bytes memory data
    ) internal {
        if (to.hasContractCode()) {
            (uint256 tokenId, uint256 maxTokenId) = _mint(es, to, amount);

            while (tokenId < maxTokenId) {
                emit Transfer(address(0), to, tokenId);
                unchecked {
                    require(
                        _checkOnERC721Received(address(0), to, tokenId++, data),
                        "ERC721Utils: transfer to non-ERC721Receiver implementer"
                    );
                }
            }
        } else {
            mint(es, to, amount);
        }
    }

    function mint(
        ERC721Storage storage es,
        address to,
        uint256 amount
    ) internal {
        (uint256 tokenId, uint256 maxTokenId) = _mint(es, to, amount);
        
        while (tokenId < maxTokenId) {
            unchecked {
                emit Transfer(address(0), to, tokenId++);
            }
        }
    }

    function _mint(
        ERC721Storage storage es,
        address to,
        uint256 amount
    ) private returns (uint256 tokenId, uint256 maxTokenId) {
        uint256 supply = es.supply;
        uint256 inventory = es.inventories[to];
        uint256 minted = inventory.minted();

        unchecked {
            require(amount < supply + 1, "ERC721Utils: mint amount exceeds supply");

            es.inventories[to] = inventory.mint(amount);
            es.supply = supply - amount;

            uint256 tid = to.toTokenId() | minted;
            return (tid, tid + amount);
        }
    }

    function burn(ERC721Storage storage es, uint256 tokenId) internal {
        address owner = ownerOf(es, tokenId);

        // Clear approvals
        approve(es, address(0), tokenId);

        if (es.owners[tokenId] == owner) {
            delete es.owners[tokenId];
            es.inventories[owner]--;
        } else {
            es.inventories[owner] = es.inventories[owner].remove(tokenId.index());
        }

        unchecked {
            es.burned++;
        }

        emit Transfer(owner, address(0), tokenId);
    }

    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    function approve(ERC721Storage storage es, address to, uint256 tokenId) internal {
        es.tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(es, tokenId), to, tokenId);
    }

    function getApproved(ERC721Storage storage es, uint256 tokenId) internal view returns (address) {
        return es.tokenApprovals[tokenId];
    }

    function isApprovedOrOwner(ERC721Storage storage es, address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(
            exists(es, tokenId),
            "ERC721Utils: operator query for nonexistent token"
        );
        address owner = ownerOf(es, tokenId);
        return (spender == owner ||
            getApproved(es, tokenId) == spender ||
            isApprovedForAll(es, owner, spender));
    }

    function enforceIsApprovedOrOwner(
        ERC721Storage storage es,
        address spender,
        uint256 tokenId
    ) internal view {
        require(
            isApprovedOrOwner(es, spender, tokenId),
            "ERC721Utils: spender is not owner nor approved"
        );
    }
    
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function setApprovalForAll(
        ERC721Storage storage es,
        address owner,
        address operator,
        bool approved
    ) internal {
        require(owner != operator, "ERC721Utils: approval to owner");
        es.operatorApprovals[owner][operator] = approved;
        emit ApprovalForAll(owner, operator, approved);
    }

    function isApprovedForAll(ERC721Storage storage es, address owner, address operator)
        internal
        view
        returns (bool)
    {
        return es.operatorApprovals[owner][operator];
    }
    
    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) private returns (bool) {
        try
            IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data)
        returns (bytes4 retval) {
            return retval == IERC721Receiver.onERC721Received.selector;
        } catch (bytes memory) {
            return false;
        }
    }
}