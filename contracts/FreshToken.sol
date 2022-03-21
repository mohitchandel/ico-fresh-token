// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract FreshToken is ERC20 {
    constructor() ERC20("Fresh Token", "FRTK") {}

    function mintToken(address _admin) public {
        _mint(_admin, 100000000 * (10**decimals()));
    }
}

