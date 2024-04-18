# Simbolik Example

Welcome to the Simbolik Example repository, your gateway to exploring Simbolik - the Solidity Debugger.

## Getting Started

To begin your debugging journey, open this repository in VSCode, install the Simbolik VSCode extension and its dependencies.
Once you've installed the extension, navigate to the [test/DebugERC20.sol](./test/DebugERC20.sol) file.
You'll find a "Debug" button above to the `debug_transfer_self` function.
Simply click it to initiate the debugging process.

## Purpose

This repository serves a dual purpose: it offers a simple debugging example and provides a template for projects seeking to integrate Solidity debugging with Simbolik.

### Requirements

Before you proceed, familiarize yourself with the current prerequisites for Simbolik:

- Your project must be a Foundry project.
- Debugging should commence from a parameterless function. While functions with parameters can be debugged, start by invoking a parameterless function and then proceed to the desired function. Refer to the `debug_transfer_self` function for an example. Further details are provided in the "Configuration as Code" section below.
- Debugging must initiate from an external or public function. If debugging a private function is necessary, call it from a public function. The `debug_mint` function illustrates this approach. This is just another instance of the "Configuration as Code" philosophy.
- Currently, Foundry Cheatcodes are not supported. Should the debugger encounter one, it will revert. Rest assured, our team is diligently working on this feature.

## Configuration as Code

Simbolik aims for simplicity by adopting a zero-configuration approach. This entails using sensible default values, prioritizing convention over configuration, and employing plain-old Solidity code as the configuration format.
The benefit of this approach is that the semantics of the configuration are clear to Solidity developers, you can commit them to your repository and share your debugging configurations with others.

We consider debugging as important as tests, and hence we believe that debugging configurations should be part of the codebase.

As an example, the `test/DebugERC20.sol` file contains the debugging configuration for the ERC20 contract. Notice, how it is just plain-old Solidity smart contract.