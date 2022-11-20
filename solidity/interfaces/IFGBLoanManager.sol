// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IFGBLoanManager { 

    function notifyLoanStatusChange(string memory _status) external returns (bool _recieved);    

    function repatriateFunds(uint256 _amount) external payable returns (bool _credited);

    function requestActivation() external returns (bool _activated);

}