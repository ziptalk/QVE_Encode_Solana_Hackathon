// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract QVE is ERC20 {
    constructor() ERC20("QVE", "QVE") {
       _mint(msg.sender, 100000000000000000000);
    }

    modifier onlyLiquidStakingOwner(address _account) {
        require(msg.sender == _account, "not authorized");
        _;
    }
    
    function mintToken(address owner, address account, uint amount) external onlyLiquidStakingOwner(owner) {
        _mint(account, amount);
    }
}