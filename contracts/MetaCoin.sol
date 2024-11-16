// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

import "./ConvertLib.sol";
import "./Owned.sol";
import "./Logger.sol";


contract MetaCoin is Owned, Logger{
	uint public 	nmbOfFunders;
	mapping (address => uint) balances;
	mapping (uint => address) public funders;
	modifier limitWithraw(uint amount) {
		require(amount <= 1000000000000000000, "The amount must be less than 1 eth");
		_;
	} 


	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() {
		//owner = msg.sender;
		//balances[tx.origin] = 10000;
	}

	function emitLog() public override pure returns(bytes32) {
		return "Log";
	}
	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
	function addFunds() external payable {
		uint index = nmbOfFunders++; 
		funders[index] = msg.sender;
	}

	function withraw(uint amount) external limitWithraw(amount) {
		
		payable(msg.sender).transfer(amount);
	}

	function getFunderAtIndex(uint8 index) external view returns(address) {
			return funders[index];
	}
	function getAllFunders()external view returns(address[] memory){
		address[]memory _funders = new address[](nmbOfFunders);
		for(uint i=0; i <= nmbOfFunders; i++ ) {
			_funders[i] = funders[i];
		}
		return _funders;
	}
	 receive() external payable {

	}
}
