// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Counter } from "../src/Counter.sol";

contract DebugCounter {

    Counter counter;

    constructor() {
        counter = new Counter();
    }

    function debugSetNumber() public {
        counter.setNumber(42);
        return;
    }

    function debugIncrement() public {
        counter.increment();
        return;
    }

}