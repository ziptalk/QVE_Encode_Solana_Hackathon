//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./arbQVE.sol";
import "./QVE.sol";

contract Stake {

    mapping(address => uint256) public staked_arbQVE;
    mapping(address => uint256) public staked_QVE;

    uint256 public total_arbQVE;
    uint256 public total_QVE;
    uint256 public arbQVESupply;
    uint256 public QVESupply;
    uint256 public arbQVEDeduction;
    uint256 public QVEDeduction;

    IERC20 public arbQve;
    IERC20 public Qve;

    constructor(IERC20 _arbQVE, IERC20 _QVE) {
        arbQve = _arbQVE;
        Qve = _QVE;
    }

    function StakeArbQVE(uint amount) public {
        require(amount > 0, "Stake amount must be greater than 0");
        arbQve.transferFrom(msg.sender, address(this), amount);
        staked_arbQVE[msg.sender] += amount;
        arbQVESupply += amount;
        arbQVE arbQveContract = arbQVE(address(arbQve));
        arbQveContract.mintToken(address(this), msg.sender, amount / 10);
    }

    function StakeQVE(uint amount) public { 
        require(amount > 0, "Stake amount must be greater than 0");
        Qve.transferFrom(msg.sender, address(this), amount);
        staked_QVE[msg.sender] += amount;
        QVESupply += amount;
        QVE QveContract = QVE(address(Qve));
        QveContract.mintToken(address(this), msg.sender, amount / 10);

    }

    function UnstakeArvQVE(uint amount) public {
        require(amount > 0, "UnStake amount must be greater than 0");
        arbQve.transfer(msg.sender, amount);
        staked_arbQVE[msg.sender] -= amount;
        arbQVEDeduction += amount;
    }

    function UnstakeQVE(uint amount) public {
        require(amount > 0, "UnStake amount must be greater than 0");
        Qve.transfer(msg.sender, amount);
        staked_QVE[msg.sender] -= amount;
        QVEDeduction += amount;
    }

    function getTotal_arbQVE() public view returns(uint){
        return arbQVESupply - arbQVEDeduction;
    }

    function getTotal_QVE() public view returns(uint) {
        return QVESupply - QVEDeduction;
    }

}