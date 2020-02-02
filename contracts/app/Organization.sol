pragma solidity 0.4.21;

import "./Employee.sol";
import "./CharityEvent.sol";
import "./IncomingDonation.sol";
import "./interfaces/OpenCharityTokenInterface.sol";


contract Organization {
	OpenCharityTokenInterface token;

	string public name;
	mapping(address => bool) public admins;
	mapping(address => bool) public charityEvents;
	mapping(uint => address) public charityEventIndex;
	uint public charityEventCount = 0;
	event CharityEventAdded(address indexed charityEvent);
	event CharityEventEdited(address indexed charityEvent, address indexed who);

	mapping(address => bool) public incomingDonations;
	mapping(uint => address) public incomingDonationIndex;
	uint public incomingDonationCount = 0;
	event IncomingDonationAdded(address indexed incomingDonation, uint amount, uint sourceId);

	event MetaStorageHashUpdated(address indexed ownerAddress, string metaStorageHash);
	uint public incomingDonationsSourceIds = 0;
	mapping(uint => string) public incomingDonationsSourceName;
	uint public creationBlockNumber;

	event FundsMovedToCharityEvent(address indexed incomingDonation, address indexed charityEvent, address indexed sender, uint amount);



	function Organization(OpenCharityTokenInterface _token, address[] _admins, string _name) public {
		require(_admins.length > 0);
		for(uint i = 0; i < _admins.length; i++) {
			require(_admins[i] != address(0x0));
			admins[_admins[i]] = true;
		}

		name = _name;
		token = OpenCharityTokenInterface(_token);

		creationBlockNumber = block.number;

	}
	function addCharityEvent(string _name, uint _target, uint _payed, bytes1 _tags, string _metaStorageHash) public onlyAdmin returns(address) {
		CharityEvent charityEvent = new CharityEvent(_name, _target, _payed, _tags, _metaStorageHash);
		charityEventIndex[charityEventCount] = charityEvent;
		charityEvents[charityEvent] = true;
		charityEventCount++;
		CharityEventAdded(charityEvent);
		return charityEvent;
	}

	function setIncomingDonation(string _realWorldIdentifier, uint _amount, string _note, bytes1 _tags, uint _sourceId) public onlyAdmin returns(address) {
		address incomingDonation = addIncomingDonation(_realWorldIdentifier, _amount, _note, _tags, _sourceId);

		token.mint(incomingDonation, _amount);

		return incomingDonation;
	}
	function addIncomingDonation(string _realWorldIdentifier, uint _amount, string _note, bytes1 _tags, uint _sourceId) internal returns(address) {
		require(_sourceId >= 0 && _sourceId <= incomingDonationsSourceIds);

		IncomingDonation incomingDonation = new IncomingDonation(token, _realWorldIdentifier, _note, _tags, _sourceId);

		incomingDonationIndex[incomingDonationCount] = incomingDonation;
		incomingDonations[incomingDonation] = true;
		incomingDonationCount++;
		IncomingDonationAdded(incomingDonation, _amount, _sourceId);

		return incomingDonation;
	}

	function moveDonationFundsToCharityEvent(address _incomingDonation, address _charityEvent, uint _amount) public {
		require(IncomingDonation(_incomingDonation).isIncomingDonation());
		require(CharityEvent(_charityEvent).isCharityEvent());
		require(IncomingDonation(_incomingDonation).moveToCharityEvent(_charityEvent, _amount));

		FundsMovedToCharityEvent(_incomingDonation, _charityEvent, msg.sender, _amount);

	}

	function updateCharityEventMetaStorageHash(address _charityEvent, string _hash) public onlyAdmin {
		require(CharityEvent(_charityEvent).isCharityEvent());

		CharityEvent(_charityEvent).updateMetaStorageHash(_hash);

		MetaStorageHashUpdated(_charityEvent, _hash);

		CharityEventEdited(_charityEvent, msg.sender);
	}

	function updateCharityEventDetails(address _charityEvent, string _name, uint _target, bytes1 _tags, string _metaStorageHash) public onlyAdmin returns(bool) {
		require(_charityEvent != address(0x0));
		CharityEvent charityEvent = CharityEvent(_charityEvent);
		require(charityEvent.isCharityEvent());
		require(token.balanceOf(charityEvent) <= _target);

		bool isMetaStorageUpdated = !(charityEvent.isTheSameMetaStorageHash(_metaStorageHash));
		require(charityEvent.updateCharityEventDetails(_name, _target, _tags, _metaStorageHash));

		CharityEventEdited(_charityEvent, msg.sender);

		if (isMetaStorageUpdated) {
			MetaStorageHashUpdated(charityEvent, _metaStorageHash);
		}

		return true;
	}

	function addIncomingDonationSource(string _name) public onlyAdmin returns(uint) {
		incomingDonationsSourceName[incomingDonationsSourceIds] = _name;

		incomingDonationsSourceIds = incomingDonationsSourceIds + 1;

		return incomingDonationsSourceIds - 1;
	}


	function isAdmin() view external returns (bool) {
		return(admins[msg.sender]);
	}
	function setAdmin(address admin, bool value) public onlyAdmin {
		admins[admin] = value;
	}


	modifier onlyAdmin() {
		require(admins[msg.sender]);
		_;
	}
}
