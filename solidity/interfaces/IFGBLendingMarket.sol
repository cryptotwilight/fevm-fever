// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IFGBLendingMarket { 

    function getAvailableFunds() view external returns (uint256 _funds);

    function getOutstandingCapital() view external returns (uint256 _outstandingCapital);

    function getProjectedEarnings() view external returns (uint256 _earnedAmount, uint256 _latestDate);

    function getOutstandingLoans() external returns (address [] memory _outstandingLoans);

    function borrow(address _minerAddress, uint256 _requestedTerm, uint256 _loanAmount, uint256 [] memory _collateralDeals, address _greenFilNftContract, uint256 _greenFilNftId ) external returns (address _loanContract);    

    function lend(uint256 _maxTerm, uint256 _funds) external payable returns (address _bondContract);

}