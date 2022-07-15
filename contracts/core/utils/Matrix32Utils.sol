// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Matrix32Utils {
    function flatten(bytes32 matPtr) internal pure {
        uint256 length = count(matPtr);
        bytes memory arr = new bytes((2 + length) << 5);

        assembly {
            let matEnd := add(matPtr, shl(5, mload(matPtr)))
            let arrPtr := add(arr, 0x40)

            mstore(add(arr, 0x20), 0x20)
            mstore(arrPtr, length)

            for {} lt(matPtr, matEnd) {} {
                matPtr := add(matPtr, 0x20)
                let rowPtr := mload(matPtr)
                let rowEnd := add(rowPtr, shl(5, mload(rowPtr)))
                
                for {} lt(rowPtr, rowEnd) {} {
                    rowPtr := add(rowPtr, 0x20)
                    arrPtr := add(arrPtr, 0x20)
                    mstore(arrPtr, mload(rowPtr))
                }
            }

            return(add(arr, 0x20), mload(arr))
        }
    }

    function count(bytes32 matPtr) internal pure returns (uint256 res) {
        assembly {
            let matEnd := add(matPtr, shl(5, mload(matPtr)))

            for {} lt(matPtr, matEnd) {} {
                matPtr := add(matPtr, 0x20)
                res := add(res, mload(mload(matPtr)))
            }
        }
    }
}
