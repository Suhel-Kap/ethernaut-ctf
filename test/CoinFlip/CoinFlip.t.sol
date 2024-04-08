// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CoinFlip} from "../../src/CoinFlip/CoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip public coinflip;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function setUp() public {
        coinflip = new CoinFlip();
    }

    function testFlip() public {
        for (uint i = 0; i < 10; i++) {
            uint256 blockNumber = block.number;
            bool side = guess();
            require(coinflip.flip(side), "Failed to flip coin");
            vm.roll(blockNumber + 1);
        }

        console.log("Consecutive Wins: %d", coinflip.consecutiveWins());
    }

    function guess() public returns (bool side) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        side = coinFlip == 1 ? true : false;
    }
}
