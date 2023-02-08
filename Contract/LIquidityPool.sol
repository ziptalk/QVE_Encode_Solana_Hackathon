// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract LiquidityPool {
    address public owner;
    IERC20 public immutable token1;
    IERC20 public immutable token2;

    mapping(address => uint) public Token1Liquidity;
    mapping(address => uint) public Token2Liquidity;

    uint public TotalToken1Supply = 1;
    uint public TotalToken2Supply = 1;
    uint public TotalToken1Deduction = 0;
    uint public TotalToken2Deduction = 0;


    constructor(IERC20 _token1, IERC20 _token2) {
        token1 = _token1;
        token2 = _token2;
        owner = msg.sender;
    }

    function addLiquidity_1(uint256 amount1) public {
        require(amount1 > 0, "Amounts must be greater than 0");
        uint amount2 = amount1 * (TotalToken2Supply - TotalToken2Deduction) / (TotalToken1Supply - TotalToken1Deduction);
        token1.transferFrom(msg.sender, address(this), amount1);
        token2.transferFrom(msg.sender, address(this), amount2);
        Token1Liquidity[msg.sender] += amount1;
        Token2Liquidity[msg.sender] += amount2;
        TotalToken1Supply += amount1;
        TotalToken2Supply += amount2;
    }

    function getLiquidity_2(uint amount) public view returns(uint) {
        require(amount > 0, "Amounts must be greater than 0");
        uint returnAmount = amount * (TotalToken2Supply - TotalToken2Deduction) / (TotalToken1Supply - TotalToken1Deduction);
        return returnAmount;
    }

    function addLiquidity_2(uint256 amount1) public {
        require(amount1 > 0, "Amounts must be greater than 0");
        uint amount2 = amount1 * (TotalToken1Supply - TotalToken1Deduction) / (TotalToken2Supply - TotalToken2Deduction);
        token1.transferFrom(msg.sender, address(this), amount1);
        token2.transferFrom(msg.sender, address(this), amount2);
        Token1Liquidity[msg.sender] += amount1;
        Token2Liquidity[msg.sender] += amount2;
        TotalToken1Supply += amount1;
        TotalToken2Supply += amount2;
    }

    function getLiquidityValue_1(uint amount) public view returns(uint) {
        require(amount > 0, "Amounts must be greater than 0");
        uint returnAmount = amount * (TotalToken1Supply - TotalToken1Deduction) / (TotalToken2Supply - TotalToken2Deduction);
        return returnAmount;
    }

    function swapAtoB(uint amount) public {
        require(amount > 0, "Amounts must be greater than 0");
        uint totalMul = (TotalToken1Supply - TotalToken1Deduction) * (TotalToken2Supply - TotalToken2Deduction);
        uint returnAmount = (TotalToken2Supply - TotalToken2Deduction) - (totalMul / (amount + (TotalToken1Supply - TotalToken1Deduction)));
        token1.transferFrom(msg.sender, address(this), amount);
        token2.transfer(msg.sender, returnAmount);
        TotalToken1Supply += amount;
        TotalToken2Deduction += returnAmount;
    }

    function getSwapAtoBReturnAmount(uint amount) public view returns(uint) {
        require(amount > 0, "Amounts must be greater than 0");
        uint returnAmount = amount * (TotalToken2Supply - TotalToken2Deduction) / (TotalToken1Supply - TotalToken1Deduction);
        return returnAmount;
    }

    function swapBtoA(uint amount) public {
        require(amount > 0, "Amounts must be greater than 0");
        uint totalMul = (TotalToken1Supply - TotalToken1Deduction) * (TotalToken2Supply - TotalToken2Deduction);
        uint returnAmount = (TotalToken1Supply - TotalToken1Deduction) - (totalMul / (amount + (TotalToken2Supply - TotalToken2Deduction)));
        token2.transferFrom(msg.sender, address(this), amount);
        token1.transfer(msg.sender, returnAmount);
        TotalToken2Supply += amount;
        TotalToken1Deduction += returnAmount;
    }

    function getSwapBtoAReturnAmount(uint amount) public view returns(uint) {
        uint totalMul = (TotalToken1Supply - TotalToken1Deduction) * (TotalToken2Supply - TotalToken2Deduction);
        uint returnAmount = (TotalToken1Supply - TotalToken1Deduction) - (totalMul / (amount + (TotalToken2Supply - TotalToken2Deduction)));
        return returnAmount;
    }

    function getTotalA() public view returns(uint) {
        return TotalToken1Supply - TotalToken1Deduction;
    }

    function getTotalB() public view returns(uint) {
        return TotalToken2Supply - TotalToken2Deduction;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}