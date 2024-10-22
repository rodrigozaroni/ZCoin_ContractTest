// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract zcoin{
    mapping(address => uint) public balances;

    uint public totalSupply = 21000000 * 10 * 18 ;
    string public name = "ZCoin" ;
    string public symbol = "ZC";
    uint public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint value);

constructor(){
    balances[msg.sender] = totalSupply;
}

function balanceOf(address owner) public view returns(uint){
    return balances[owner];
}

function transfer(address to, uint value) public returns(bool){
    require(balanceOf(msg.sender) >= value,'Qtd de ZCoins insuficiente');
    balances[to] += value;
    balances[msg.sender] -= value;
    emit Transfer(msg.sender,to, value);
    return true;
}
}


