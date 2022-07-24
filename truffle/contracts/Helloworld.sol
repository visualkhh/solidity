// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Helloworld {
  string public message;
  constructor() public {
    message = "HELLO";
  }
  function hello() public pure returns (string memory) {
    return "Hello World";
  }
}
