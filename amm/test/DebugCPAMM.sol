// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "../src/ERC20.sol";
import {CPAMM} from "../src/CPAMM.sol";

contract DebugCPAMM {
    ERC20 token0;
    ERC20 token1;
    CPAMM cpamm;
    LiquidityProvider alice;
    Swapper bob;

    constructor() {
        token0 = new ERC20("token0", "TK0", 0);
        token1 = new ERC20("token1", "TK1", 0);
        cpamm = new CPAMM(address(token0), address(token1));
        alice = new LiquidityProvider(cpamm);
        bob = new Swapper(cpamm);

        // Deal 1000 of each token to Alice and Bob
        token0.mint(address(alice), 1000);
        token1.mint(address(alice), 1000);
        token0.mint(address(bob), 1000);
        token1.mint(address(bob), 1000);
    }

    function debugAddLiquidity() public {
        uint256 aliceShares = alice.addLiquidity(100, 100);
        return;
    }

    function debugSwap() public {
        // Alice's and Bob's balances before the swap
        uint256 alice0Before = token0.balanceOf(address(alice));
        uint256 alice1Before = token1.balanceOf(address(alice));
        uint256 bob0Before = token0.balanceOf(address(bob));
        uint256 bob1Before = token1.balanceOf(address(bob));

        // Alice adds liquidity
        uint256 aliceShares = alice.addLiquidity(100, 100);

        // Bob swaps 50 tokens
        bob.swap(address(token0), 50);

        // Alice removes liquidity
        alice.removeLiquidity(aliceShares);

        // Alice's and Bob's balances after the swap
        uint256 alice0After = token0.balanceOf(address(alice));
        uint256 alice1After = token1.balanceOf(address(alice));
        uint256 bob0After = token0.balanceOf(address(bob));
        uint256 bob1After = token1.balanceOf(address(bob));
        return;
    }
}

/**
 * An Actor that can add and remove liquidity from a CPAMM
 */
contract LiquidityProvider {
    CPAMM cpamm;

    constructor(CPAMM _cpamm) {
        cpamm = _cpamm;
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external returns (uint256) {
        cpamm.token0().approve(address(cpamm), amountA);
        cpamm.token1().approve(address(cpamm), amountB);
        return cpamm.addLiquidity(amountA, amountB);
    }

    function removeLiquidity(uint256 amount) external {
        cpamm.removeLiquidity(amount);
    }
}

/**
 * An Actor that can swap tokens on a CPAMM
 */
contract Swapper {
    CPAMM cpamm;

    constructor(CPAMM _cpamm) {
        cpamm = _cpamm;
    }

    function swap(address tokenIn, uint256 amountIn) external {
        ERC20(tokenIn).approve(address(cpamm), amountIn);
        cpamm.swap(tokenIn, amountIn);
    }
}