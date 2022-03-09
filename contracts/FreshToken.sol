// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract FreshToken is ERC20 {
    constructor() ERC20("Fresh Token", "FRTK") {}

    function mintToken(address _admin) public {
        _mint(_admin, 100000000 * (10**decimals()));
    }
}

contract FreshTokenCrowdsale {
    address payable admin;
    FreshToken public token;
    uint256 public tokenPrice;
    uint256 public totalSold;
    uint8 public icoPhase;

    constructor(FreshToken _tokenAddress) {
        admin = payable(msg.sender);
        token = _tokenAddress;
        _setTokenPrice(2538, 125);
    }

    receive() external payable {
        buyFreshToken(msg.value);
    }

    //Buy fresh tokens
    function buyFreshToken(uint256 _amount) public payable {
        require(icoPhase != 0, "ICO Not Started");
        require(icoPhase != 3, "ICO Ended");
        require(
            _amount < token.balanceOf(address(this)),
            "This much amount is not available"
        );
        uint256 total = _amount / tokenPrice;
        token.transfer(msg.sender, total);
        totalSold = total + totalSold;
        if (totalSold == 30000000 * 10**18) {
            _setIcoPhase(2);
        }
    }

    // token price setting (ref: - https://www.edureka.co/community/22207/how-to-set-token-price-in-solidity)
    function _setTokenPrice(uint256 _ethrate, uint256 _tokenprice) internal {
        tokenPrice = (1 ether * _tokenprice) / _ethrate / 10000;
    }

    // Set ICO phase
    function _setIcoPhase(uint8 _phase) internal {
        icoPhase = _phase;
        if (icoPhase > 1) {
            _setTokenPrice(2538, 225);
        }
    }

    // Send token from admin account to smart contract
    function startCrowdsale() public onlyAdmin {
        icoPhase = 1;
        token.mintToken(address(this));
    }

    // Recieve all ethers present in smart contract
    function endCrowdsale() public payable onlyAdmin {
        icoPhase = 3;
        admin.transfer(msg.value);
    }

    // function modifier for admin use only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can do this");
        _;
    }

    // checking token balance of any address
    function totalOf(address _address) public view returns (uint256) {
        return token.balanceOf(_address);
    }
}
