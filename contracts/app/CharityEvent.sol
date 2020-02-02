pragma solidity 0.4.21;

import "./OrganizationInterface.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract CharityEvent is Ownable {
    string public name;
    uint public target;
    uint public payed;
    bytes1 public tags;
	string public metaStorageHash;


    function CharityEvent(string _name, uint _target, uint _payed, bytes1 _tags, string _metaStorageHash) public {
        require(_target > 0);
        require(_payed >= 0);

        name = _name;
        target = _target;
        payed = _payed;
        tags = _tags;

		metaStorageHash = _metaStorageHash;
    }
	function updateCharityEventDetails(string _name, uint _target, bytes1 _tags, string _metaStorageHash) public onlyOwner returns(bool) {

		name = _name;

		target = _target;

		tags = _tags;

		metaStorageHash = _metaStorageHash;

		return true;
	}



	function updateMetaStorageHash(string _metaStorageHash) public  {
		metaStorageHash = _metaStorageHash;
	}

	function isTheSameMetaStorageHash(string _toCompare) public view returns(bool) {
		return (keccak256(metaStorageHash) == keccak256(_toCompare));
	}

	function isCharityEvent() pure external returns (bool) {
		return true;
	}


}
