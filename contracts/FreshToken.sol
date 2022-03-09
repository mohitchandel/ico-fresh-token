// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract FreshToken is ERC20{

    address admin;

    constructor(uint256 _totalSupply) ERC20("Fresh Token", "FRTK"){
        admin = msg.sender;
        _mint(admin, _totalSupply * (10 ** decimals()));
    }
}

contract FreshTokenCrowdsale {

    address payable admin;
    FreshToken public token;
    uint256 public tokenPrice;
    uint256 public totalSold;
    uint8 public icoPhase;
    uint256 public totalTokens;

    constructor (FreshToken _tokenAddress, uint32 _currentEthrate){
        admin = payable(msg.sender);
        token = _tokenAddress;
        icoPhase = 1;
        _setTokenPrice(_currentEthrate, 125);
    }

    receive () external payable{
        buyFreshToken(msg.value);
    }

    //Buy fresh tokens
    function buyFreshToken(uint256 _amount) payable public {
        require(icoPhase == 0, "ICO Ended");
        require (_amount >= totalTokens, "This much amount is not available");
        require (_amount >= totalTokens - totalSold, "This much amount is not available");
        uint256 total = _amount / tokenPrice;
        token.transfer(msg.sender, total);
        totalSold = total + totalSold;
        if(totalSold == 30000000 * (10 ** 18)){
            _setIcoPhase(2);
        }
    }

    // token price setting (ref: - https://www.edureka.co/community/22207/how-to-set-token-price-in-solidity)
    function _setTokenPrice(uint256 _ethrate, uint256 _tokenprice) internal {
        tokenPrice = (1 ether * _tokenprice ) / _ethrate / 10000;
    }

    function _setIcoPhase(uint8 _phase) internal {
        icoPhase = _phase;
        if(icoPhase > 1){
            _setTokenPrice(2538, 225);
        }
    }

    // Send token from admin account to smart contract
    function startCrowdsale(uint256 _tokens) public onlyAdmin{
        totalTokens = _tokens;
        token.transfer(address(this), totalTokens);
    }

    // Recieve all ethers present in smart contract
    function endCrowdsale() public payable onlyAdmin{
        icoPhase = 0;
        admin.transfer(msg.value);
    }

    // function modifier for admin use only
    modifier onlyAdmin(){
        require(msg.sender == admin, "Only admin can do this");
        _;
    }

    // checking token balance of any address
    function totalOf(address _address) public view returns(uint256){
        return token.balanceOf(_address);
    }
}
