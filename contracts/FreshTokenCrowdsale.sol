// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FreshToken.sol";

contract FreshTokenCrowdsale {

    address payable admin;
    uint256 public totalTokens; 
    FreshToken public token;
    uint256 public rate;
    uint256 public tokenPrice;
    uint256 public totalSold;
    uint32 public icoPhase;
    uint256 public tokenForSale;

    constructor (FreshToken _tokenAddress) {
        totalTokens = 100000000 * (10 ** 18);
        admin = payable(msg.sender);
        token = _tokenAddress;
        icoPhase = 0;
    }

    receive () external payable{
        buyFreshToken(msg.value);
    }

    function startCrowdsale() public onlyAdmin{
        icoPhase = 1;
    }

    //Buy fresh tokens
    function buyFreshToken(uint256 _amount) payable public {
        require (icoPhase != 0, "ICO not started yet");
        require (icoPhase != 3, "ICO Ended");
        require (totalSold != totalTokens, "ICO ENDED");
        getRate(icoPhase);
        uint total = _amount / rate;
        require (total < tokenForSale, "Token amount exeed");
        token.transfer(msg.sender, total);
        totalSold = total + totalSold;
        if (totalSold >= 300000000 * (10**18)){
            icoPhase = 2;
        }
        if(totalTokens == totalSold){
            icoPhase = 3;
        }
        admin.transfer(msg.value);
    }

    // Setting Token according to ICO Phase
    function getRate(uint256 _icoPhase) internal {
        uint16 ethPrice = 2870;
        if(_icoPhase == 1){
            // for pre sale
            tokenPrice = 125;
            uint256 tokenInWei = 1 ether * tokenPrice;
            tokenForSale = 300000000 * (10**18);
            rate = tokenInWei / ethPrice / 1000;
        }else if(_icoPhase == 2){
            // for seed sale
            tokenPrice = 225;
            uint256 tokenInWei = 1 ether * tokenPrice;
            tokenForSale = totalTokens - tokenForSale;
            rate = tokenInWei / ethPrice / 1000;
        }
    }

    // function modifier for admin use only
    modifier onlyAdmin(){
        require(msg.sender == admin, "Only admin can do this");
        _;
    }

}