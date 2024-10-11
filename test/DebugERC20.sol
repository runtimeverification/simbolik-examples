// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/BuggyERC20.sol";

contract DebugToken is BuggyERC20 {

    address public constant ALICE = address(0x100);
    address public constant BOB = address(0x200);

    constructor() {
        _mint(msg.sender, 10000);
        _mint(ALICE, 1000);
        _mint(BOB, 100);
    }

    function debug_mint() external {
        _mint(ALICE, 1000);
    }

    function debug_approve() external {
        approve(BOB, 1000);
    }

    function debug_transfer() external {
        transfer(ALICE, 1000);
    }

    function debug_transfer_self() external {
        uint256 balanceBefore = balanceOf[msg.sender];
        transfer(msg.sender, 1000);
        uint256 balanceAfter = balanceOf[msg.sender];
        assert(balanceBefore == balanceAfter);
    }

}