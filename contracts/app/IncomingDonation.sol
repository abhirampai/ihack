pragma solidity 0.4.21;

import './interfaces/OpenCharityTokenInterface.sol';
import './CharityEvent.sol';

contract IncomingDonation {

	OpenCharityTokenInterface public token;
    string public realWorldIdentifier;
    bytes1 zeroBytes = 0x00;
    bytes1 public tags;
    string public note;
	uint public sourceId;


    function IncomingDonation(address _token, string _realWorldIdentifier, string _note, bytes1 _tags, uint _sourceId) public {
        require(_token != address(0x0));
		require(_sourceId >= 0);

        token = OpenCharityTokenInterface(_token);

        realWorldIdentifier = _realWorldIdentifier;
        note = _note;
        tags = _tags;
		sourceId = _sourceId;
    }
    function moveToCharityEvent(address _charityEvent, uint _amount) public returns(bool) {
        require(_amount > 0);

        CharityEvent charityEvent = CharityEvent(_charityEvent);

        require(charityEvent.isCharityEvent());

        require(validateTags(tags, charityEvent.tags()));

        token.transfer(_charityEvent, _amount);

		return true;
    }
    function validateTags(bytes1 donationTags, bytes1 eventTags) view public returns (bool)  {
		if (donationTags == zeroBytes || eventTags == zeroBytes) {
			return true;
		}

        return ( (donationTags & eventTags) > zeroBytes);
    }
    function isIncomingDonation() pure public returns (bool) {
        return true;
    }


}
