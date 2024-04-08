// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Telephone} from "../../src/Telephone/Telephone.sol";

contract TelephoneTest is Test {
    Telephone public telephone;
    address newOwner = address(1);
    address txOrigin = address(2);

    function setUp() public {
        telephone = new Telephone();
    }

    function testChangeOwner() public {
        console.log("Owner: %s", telephone.owner());

        vm.prank(txOrigin);
        telephone.changeOwner(newOwner);

        console.log("Owner: %s", telephone.owner());

        assertEq(telephone.owner(), newOwner);
    }
}
