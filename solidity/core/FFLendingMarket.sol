// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/Zondax/fevm-solidity-mock-api/blob/7ad2f617a6a69303aab5c73ebc3690e2e2a57336/contracts/v0.8/MarketAPI.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/99589794db43c8b285f5b3464d2e0864caab8199/contracts/utils/Strings.sol";

import "../interfaces/IFFLoan.sol";
import "../interfaces/IFFBond.sol";
import "../interfaces/IFFLendingMarket.sol";
import "../interfaces/IFFVersionedAddress.sol";
import "../interfaces/IFFLoanManager.sol";
import "./FFLoan.sol";

contract FFLendingMarket is IFFLendingMarket, IFFLoanManager, IFFVersionedAddress { 

    using Strings for address; 

    string constant name = "RESERVED_IFF_LENDING_MARKET"; 
    uint256 constant version = 1; 

    address self; 
    address administrator; 
    MarketAPI fileCoinMarket; 

    address [] allLoans; 
    address [] outstandingLoans; 
    address [] outstandingBonds; 
    address [] allBonds; 

    uint256 lendingPool; 

    mapping(address=>bool) knownLoan; 
    mapping(address=>bool) knownBond; 
    mapping(address=>address) loanByBorrower; 
    mapping(address=>address) bondByLender; 

    constructor(address _administrator, address _marketPlace) {
        administrator = _administrator; 
        fileCoinMarket = MarketAPI(_marketPlace);
        self = address(this);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getAvailableFunds() view external returns (uint256 _funds){
        return lendingPool; 
    }

    function getOutstandingCapital() view external returns (uint256 _outstandingCapital){
        for(uint256 x = 0; x < outstandingLoans.length; x++) {
            _outstandingCapital += IFFLoan(outstandingLoans[x]).getOutstandingBalance();
        }
        return _outstandingCapital;
    }

    function getProjectedEarnings() view external returns (uint256 _earnedAmount, uint256 _latestDate){
        for(uint256 x = 0; x < outstandingLoans.length; x++) {
            _earnedAmount += IFFLoan(outstandingLoans[x]).getConditions().interest; 
            uint256 expiryDate_ = IFFLoan(outstandingLoans[x]).getConditions().expiryDate; 
            if(_latestDate < expiryDate_){
                _latestDate = expiryDate_;
            }
        }
        return (_earnedAmount, _latestDate);
    }

    function getOutstandingLoans() view external returns (address [] memory _outstandingLoans){
        return outstandingLoans;
    }

    function getOutstandingBonds() view external returns (address [] memory _outstandingBonds) {
        return outstandingBonds;
    }

    function borrow(address _minerAddress, uint256 _requestedTerm, uint256 _loanAmount, uint256 [] memory _collateralDeals, address _greenFilNftContract, uint256 _greenFilNftId ) external returns (address _loanContract){     
        uint256 latestDealDate_ = getLatestDealExpiry(_collateralDeals);
        uint256 requestedEndDate = block.timestamp + _requestedTerm; 
        require(requestedEndDate < latestDealDate_, "term longer than available deals");
        uint256 collateral_ = getCollateral(_collateralDeals);
        require(collateral_ > _loanAmount, "insufficient collateral");

        IFFLoan.LoanBasis memory loanBasis_ = IFFLoan.LoanBasis({
                                                borrower        :  msg.sender.toHexString(),
                                                borrowerAddress : msg.sender, 
                                                collateral      : collateral_,
                                                loanAmount      :  _loanAmount,
                                                dealBasis       : _collateralDeals, 
                                                greenFilNft     : _greenFilNftContract, 
                                                greenFilNftId   : _greenFilNftId,
                                                createDate      : block.timestamp
                                                });
        IFFLoan.LoanConditions memory loanConditions_ = getLoanConditions(loanBasis_, _requestedTerm);

        FFLoan loan_ = new FFLoan(self, _minerAddress, loanBasis_, loanConditions_);
        _loanContract =  address(loan_);
        allLoans.push(_loanContract);
        knownLoan[_loanContract] = true; 
        return _loanContract;
    }

    

    function lend(uint256 _maxTerm, uint256 _funds) external payable returns (address _bondContract){

    }

    function notifyLoanStatusChange(string memory _status) external returns (bool _recieved){
        require(knownLoan[msg.sender], "unknown loan");

        return true; 
    }

    function repatriateFunds(uint256 _funds) external payable returns (bool _repatriated) {
        require(knownLoan[msg.sender], "unknown loan");

        return true; 
    }

    function requestActivation() external returns (bool _activated) {
        require(knownLoan[msg.sender], "unknown loan");
        IFFLoan loan_ = IFFLoan(msg.sender);
        loan_.credit{value : loan_.getBasis().loanAmount}();
        return true; 
    }
    // ============================= INTERNAL ======================================================================

    function getLoanConditions(IFFLoan.LoanBasis memory loanBasis_, uint256 _requestedTerm) view internal returns (IFFLoan.LoanConditions memory _conditions) {
            return IFFLoan.LoanConditions({               
                                            interest          : getInterestRate(loanBasis_.loanAmount, loanBasis_.collateral, loanBasis_.dealBasis.length, _requestedTerm),
                                            expiryDate        : loanBasis_.createDate + _requestedTerm, 
                                            liquidationFactor : getLiquidationFactor(loanBasis_.loanAmount, loanBasis_.collateral,  loanBasis_.dealBasis.length, _requestedTerm),
                                            minimumRepayment  : getMinimumRepayment(loanBasis_.loanAmount, loanBasis_.collateral, loanBasis_.dealBasis.length, _requestedTerm)
                                        });
    }


    function getMinimumRepayment(uint256 _loanAmount, uint256 _collateralAmount, uint256 _dealCount, uint256 _requestedTerm)view internal returns(uint256 _minimumRepayment) {

    }

    function getLiquidationFactor(uint256 _loanAmount, uint256 _collateralAmount, uint256 _dealCount, uint256 _requestedTerm)view internal returns (uint256 _liquidationFactor) {

    }

    function getLatestDealExpiry(uint256 [] memory _deals) view internal returns (uint256 _latestDate) {
  
    }

    function getInterestRate(uint256 _loanAmount, uint256 _availableCollateral, uint256 _dealCount, uint256 _requestedTerm) view internal returns (uint256 _interestRate){

    }

    function getCollateral(uint256 [] memory _collateralDeals) view internal returns (uint256 _collateralAmount){
      for(uint256 x = 0; x < _collateralDeals.length; x++) {
            MarketTypes.GetDealEpochPriceParams memory params = MarketTypes.GetDealEpochPriceParams({
                                                                                                        id : uint64(_collateralDeals[x])
                                                                                                    });
            _collateralAmount += fileCoinMarket.get_deal_total_price(params).price_per_epoch;
        }
        return _collateralAmount; 
    }

}