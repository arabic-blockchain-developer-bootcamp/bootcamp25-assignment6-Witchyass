// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    event FundsDeposited(address indexed sender, uint256 amount);
    event FundsWithdrawn(address indexed receiver, uint256 amount);

    mapping(address => uint256) public balances;
    // 1. Declare an event called `FundsDeposited` with parameters: `sender` and `amount`

    // 2. Declare an event called `FundsWithdrawn` with parameters: `receiver` and `amount`

    // 3. Create a public mapping called `balances` to tracker users balances

    // Modifier to check if sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether
    // This function should:
    // - Be external and payable
    // - Emit the `FundsDeposited` event
    function deposit() external payable {
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Function to withdraw Ether
    // This function should:
    // - Be external
    // - Take one parameter: `amount`
    // - Use the `hasEnoughBalance` modifier
    // - Emit the `FundsWithdrawn` event
   function withdraw(uint amount) external hasEnoughBalance(amount) {
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        emit FundsWithdrawn(msg.sender, amount);

    }

    // Function to check the contract balance
    // This function should:
    // - Be public and view
    // - Return the contract's balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    
    }
}
