pragma solidity ^0.4.0;

import "browser/ERC20.sol";

contract CentareumToken is ERC20 {
    string public constant symbol = "CTM";
    string public constant name = "Centareum Token";
    uint8 public constant decimals = 18;
    
    uint private constant amount = 1000;
    mapping (address => uint) private mybalanceOf;
    mapping (address => mapping (address => uint)) private myallowances;
    
    //Constructor
    function CentareuemToken() {
            mybalanceOf[msg.sender] = amount;
    }
    
    //Below are implementation codes for the Interface in ERC20.sol
    function totalSupply() constant returns (uint amt) {
        amt = amount;
    }
    
    function balanceOf(address addr) constant returns (uint balance) {
        return mybalanceOf[addr];
    }
    
    function transfer(address to, uint value) returns (bool success) {
        if ( value <= balanceOf(msg.sender) && value > 0) {
            mybalanceOf[msg.sender] -= value;
            mybalanceOf[to] += value;
            return true;
        }
        
        return false;
    }
    
    function transferFrom(address from, address to, uint value) returns (bool success) {
        if ( myallowances[from][msg.sender] > 0 &&
            value > 0 &&
            myallowances[from][msg.sender] >= value && 
            mybalanceOf[from] >= value) {
            mybalanceOf[from] -= value;
            mybalanceOf[to] += value;
            myallowances[from][msg.sender] -= value;
            return true;
        }
        
        return false;
    }
    
    function approve(address spender, uint value) returns (bool success) {
        myallowances[msg.sender][spender] = value;
        
        return true;
    }
    
    function allowance(address owner, address spender) constant returns (uint remaining) {
        return myallowances[owner][spender];
    }
}
