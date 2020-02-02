pragma solidity 0.4.21;

import "../node_modules/zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
contract OpenCharityMintableToken is MintableToken {
    mapping (address => bool) public mintAgents;

    event MintingAgentChanged(address addr, bool state);
    function setMintAgent(address addr, bool state) onlyOwner canMint public {
        mintAgents[addr] = state;
         MintingAgentChanged(addr, state);
    }
    function mint(address _to, uint256 _amount) onlyMintAgent canMint public returns (bool) {
        totalSupply_ = totalSupply_.add(_amount);
        balances[_to] = balances[_to].add(_amount);
         Mint(_to, _amount);
         Transfer(address(0), _to, _amount);
        return true;
    }

    function mintTest(address _to, uint256 _amount) onlyMintAgent canMint public returns (bool) {
        totalSupply_ = totalSupply_.add(_amount);
        balances[_to] = balances[_to].add(_amount);
         Mint(_to, _amount);
         Transfer(address(0), _to, _amount);
        return true;
    }


    modifier onlyMintAgent() {
        if(!mintAgents[msg.sender]) {
            revert();
        }
        _;
    }



}
