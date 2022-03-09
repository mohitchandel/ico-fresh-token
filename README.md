# ICO Fresh Token

Fresh Token Smart Contract

Token is created on Rinkeby Test network

###### How to start ICO

*StartCrowdsale* function will start ICO and mint 100 Million tokens

```
function startCrowdsale() public onlyAdmin{}
```


These 100 Million tokens are stored in smart contract

** There are two Ico phase **
1. Pres Sale - Below 30 Million (Prise - 0.0125)
2. After Pre Sale - Over 30 Million (Prise - 0.0255)

###### How to end ICO

*endCrowdsale* function will end ICO and will transfer ethereum amount present in contract 
to admin (who created smart contract).

```
function endCrowdsale() public onlyAdmin{}
```

###### Buy Fresh Token

with *buyFreshToken* users can buy Fresh Token. The user will put the Ethereum amount as a parameter and this function will calculate how many tokens will be allotted according to the given price.

```
function buyFreshToken(uint256 _amount) public payable {}
```