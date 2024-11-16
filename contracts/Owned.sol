// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

contract Owned {
    	address public owner;
	constructor() {
		owner = msg.sender;
		//balances[tx.origin] = 10000;
	}
	modifier onlyOwner() {
		require(msg.sender == owner, "only owner can do it ");
		_;
	}

}