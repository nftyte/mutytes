# Mutytes Contract

The Mutytes contract is a unique ERC721 implementation that optimizes gas and supports upgrades. Every module contains both its immutable and upgradable implementations, so contract writers can pick exactly where and how to provide upgradability (if any).

## Class Hierarchy

The various module implementations in this repo maintain a strict class hierarchy. Every class in this hierarchy may implement the same set of operations, but at a different systematic level. This separation is intended to provide added control over operation pre-conditions and post-conditions internally, as well as access to common logic externally.

A general overview of the different hierarchy levels:

| Level | Description | Example
| --- | --- | --- |
| `External` | The module's external interface. Includes both the immutable and upgradable variations. | `ERC165.sol` |
| `Controller` | The module's primary logic. Implements high-level operations that may involve assertions and event emissions. | `ERC165Controller.sol` |
| `Model` | The module's data access logic. Implements low-level operations that may involve reading and writing storage data. | `ERC165Model.sol` |
| `Storage` | The module's data storage. Technically not a part of the class hierarchy, and should only ever be accessed from a Model. | `ERC165Storage.sol` |

## Upgradability

Every module includes two external implementations, an immutable one and an upgradable one. Upgradable implementations have the `Proxy` suffix appended to their names, and all their external methods are marked with the `upgradable` modifier.

This repo includes a custom implementation of the [EIP-2535 Diamonds](https://eips.ethereum.org/EIPS/eip-2535) standard, which can be deployed and initialized separately from the main contract. Upgradable functions can be upgraded via standard `diamondCut` function.

## Deployment

```console
npx hardhat run scripts/deploy.js
```

## Tests

```console
npx hardhat test
```

## License

MIT license. Anyone can use or modify this software for their purposes.
