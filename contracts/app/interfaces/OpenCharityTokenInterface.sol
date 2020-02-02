pragma solidity 0.4.21;

import "zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";

contract OpenCharityTokenInterface is ERC20Basic {
	mapping (address => bool) public mintAgents;
	function setMintAgent(address addr, bool state)  public;
	function mint(address _to, uint256 _amount) public returns (bool);
	function mintTest(address _to, uint256 _amount) public returns (bool);
    function transfer(address _to, uint256 _value) public returns (bool);

}
