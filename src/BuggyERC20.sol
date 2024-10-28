// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { IERC20 } from "./IERC20.sol";

/**
 * This is a simple ERC20 token, with a bug in the transfer function.
 */
contract BuggyERC20 is IERC20 {
    string public name = "BuggyERC20";
    string public symbol = "BUG";
    uint8 public decimals = 18;
    uint256 public totalSupply = 0;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    address public owner;
    constructor() {
        owner = msg.sender;
        _mint(owner, 1000e18);
    }

    function _mint(address to, uint256 amount) internal {
        require(msg.sender == owner, "Only owner can mint");
        balanceOf[to] += amount;
        totalSupply += amount;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        uint256 balanceFromBefore = balanceOf[msg.sender];
        uint256 balanceToBefore = balanceOf[to];
        balanceOf[msg.sender] = balanceFromBefore - value;
        balanceOf[to] = balanceToBefore + value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Not allowed to transfer");
        uint256 balanceFromBefore = balanceOf[from];
        uint256 balanceToBefore = balanceOf[to];
        balanceOf[from] = balanceFromBefore - value;
        balanceOf[to] = balanceToBefore + value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}
