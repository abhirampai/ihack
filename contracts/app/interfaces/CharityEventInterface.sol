pragma solidity 0.4.21;

contract CharityEventInterface {
	string public name;
	uint public target;
	uint public payed;
	bytes1 public tags;
	string public metaStorageHash;


	function createCharityEvent(string _name, uint _target, uint _payed, bytes1 _tags, string _metaStorageHash) external returns(address);
	function isCharityEvent() pure external returns (bool);
	function updateDetails(string _name, uint256 _target, bytes1 _tags, string _metaStorageHash) public returns(bool);


}
