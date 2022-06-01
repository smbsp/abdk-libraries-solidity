// SPDX-License-Identifier: BSD-4-Clause
pragma solidity ^0.8.1;

import "./ABDKMath64x64.sol";

contract Test {
    int128 internal zero = ABDKMath64x64.fromInt(0);
    int128 internal one = ABDKMath64x64.fromInt(1);
    int128 private constant MIN_64x64 = -0x80000000000000000000000000000000;
    int128 private constant MAX_64x64 = 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    event Value(string, int64);

    // Wrappers
    function add(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.add(x, y);
    }

    function sub(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.sub(x, y);
    }

    // Fuzzing - Addition
    // Adds a number to 0
    function testAddNumberToZero(int128 x) public {
        // int128 a = fromInt(x);
        assert(add(x, 0) == x);
    }

    // Addition of two numbers must be greater than 0 - wrong assertion
    function testAddUnsafe(int128 x, int128 y) public {
        assert(add(x, y) >= x);
        assert(add(x, y) >= y);
    }

    // Addition of two numbers must be bounded
    function testAddBounds(int128 x, int128 y) public {
        assert(add(x, y) <= MAX_64x64);
        assert(add(x, y) >= MIN_64x64);
    }

    // Fuzzing - Substraction
    // Substracts 0 from a number
    function testSubstractionZero(int128 x) public {
        // int128 a = fromInt(x);
        assert(sub(x, 0) == x);
    }

    // Substraction of two numbers must be greater than 0 - wrong assertion
    function testSubstractionUnsafe(int128 x, int128 y) public {
        assert(sub(x, y) <= x);
        assert(sub(x, y) <= y);
    }

    // Addition of two numbers must be bounded
    function testSubstractionBounds(int128 x, int128 y) public {
        assert(sub(x, y) <= MAX_64x64);
        assert(sub(x, y) >= MIN_64x64);
    }
}
