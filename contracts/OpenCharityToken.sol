pragma solidity 0.4.21;

import "../node_modules/zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "../node_modules/zeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";
import "./OpenCharityMintableToken.sol";

contract OpenCharityToken is DetailedERC20, OpenCharityMintableToken, BurnableToken {


	function OpenCharityToken(string _name, string _symbol, uint8 _decimals)
	DetailedERC20(_name, _symbol, _decimals)
	public {
		setMintAgent(msg.sender, true);
		mint(msg.sender, 1000000 * (10**18));

	}

}
