// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Vault} from "../../src/Vault/Vault.sol";

contract VaultTest is Test {
    Vault public vault;

    function setUp() public {
        vault = new Vault(bytes32(uint256(12324)));
    }

    function test_breakVault() public {
        bytes32 password = vm.load(address(vault), bytes32(uint256(1)));

        bool stateBefore = vault.locked();
        vault.unlock(password);
        bool stateAfter = vault.locked();

        assert(stateBefore == true);
        assert(stateAfter == false);
    }
}
