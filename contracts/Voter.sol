// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

contract Voter{
    
  struct Voters{
      uint weight;
      bool hasVoted;
  }
  
  struct Candidates{
      string name;
      uint voteCount;
  }
   
    mapping(address => Voters) voters; // voters[addres] = Voters
    Candidates[] public candidatesList;
    address public owner;
    
  constructor(string memory _candidate1, string memory _candidate2, string memory _candidate3)  {
        candidatesList.push(Candidates({name : _candidate1,voteCount : 0}));
        candidatesList.push(Candidates({name : _candidate2,voteCount : 0}));
        candidatesList.push(Candidates({name : _candidate3,voteCount : 0}));
        
        owner = msg.sender;
    }
    
    function authorizeVoter(address _address) public {
        require(msg.sender == owner);
        require(!voters[_address].hasVoted);
        
        voters[_address] = Voters({weight : 1, hasVoted : false});
        //voters["0xxxjafklahlfjha"]
    }
    
    
    function voteForCandidate(uint _index) public{
        candidatesList[_index].voteCount = candidatesList[_index].voteCount + voters[msg.sender].weight;
        if(voters[msg.sender].weight > 0){
            voters[msg.sender].weight = 0;
            voters[msg.sender].hasVoted = true;
        }
    }
    
    function getVoteForCandidate(uint _index) public view returns(uint){
        return candidatesList[_index].voteCount;
    }
    
}