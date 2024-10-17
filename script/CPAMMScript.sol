// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

import {CPAMM} from "../src/CPAMM.sol";
import {ERC20} from "../src/ERC20.sol";

contract CPAMMScript is Script {
    ERC20 token0;
    ERC20 token1;
    CPAMM cpamm;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        token0 = new ERC20("token0", "TK0", 0);
        token1 = new ERC20("token1", "TK1", 0);
        cpamm = new CPAMM(address(token0), address(token1));
        vm.stopBroadcast();
    }

}
