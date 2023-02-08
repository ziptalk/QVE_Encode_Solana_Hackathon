// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./arbQVE.sol";

contract Deposit {
    IERC20 public immutable usdt;
    arbQVE public ArbQVE;
    constructor (IERC20 _usdt, arbQVE _ArbQVE) {
        usdt = _usdt;
        ArbQVE = _ArbQVE;
    }

    mapping (address => uint) balanceOfDeposit;
    mapping (address => uint) balanceOfWithdraw;

    function deposit(uint _amount) public {
        usdt.transferFrom(msg.sender, address(this), _amount);
        balanceOfDeposit[msg.sender] += _amount;
        ArbQVE.mintToken(address(this), msg.sender, _amount);
    }

    function withdraw(uint _amount) public {
        require(usdt.transfer(msg.sender, _amount));
        balanceOfWithdraw[msg.sender] += _amount;
    }

    function getBalance(address _account) public view returns (uint) {
        return balanceOfDeposit[_account] -  balanceOfWithdraw[_account];
    }
}

