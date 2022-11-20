// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/Zondax/fevm-solidity-mock-api/blob/7ad2f617a6a69303aab5c73ebc3690e2e2a57336/contracts/v0.8/MarketAPI.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/99589794db43c8b285f5b3464d2e0864caab8199/contracts/utils/Strings.sol";

import "../interfaces/IFGBLoan.sol";
import "../interfaces/IFGBGreenBond.sol";
import "../interfaces/IFGBLendingMarket.sol";
import "../interfaces/IFGBVersionedAddress.sol";
import "../interfaces/IFGBLoanManager.sol";
import "./FGBLoan.sol";
import "./FGBGreenBond.sol";

contract FGBLendingMarket is IFGBLendingMarket, IFGBLoanManager, IFGBVersionedAddress { 

    using Strings for address; 

    struct Repatriation {
        uint256 id; 
        address loan; 
        uint256 amount; 
        uint256 repatriationDate; 
    }

    string constant name = "RESERVED_IFF_LENDING_MARKET"; 
    uint256 constant version = 1; 

    address self; 
    address administrator; 
    MarketAPI fileCoinMarket; 

    uint256 [] repatriationIds; 
    mapping(uint256=>bool) knownRepatriationId; 
    mapping(address=>uint256[]) repatriationIdsByLoan; 
    mapping(uint256=>Repatriation) repatriationById; 

    address [] allLoans; 
    address [] outstandingLoans; 
    address [] outstandingBonds; 
    address [] allBonds; 

    uint256 lendingPool; 

    mapping(address=>bool) knownLoan; 
    mapping(address=>bool) knownBond; 
    mapping(address=>address) loanByBorrower; 
    mapping(address=>address) bondByLender; 

    uint256 repatriationIndex; 

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
            _outstandingCapital += IFGBLoan(outstandingLoans[x]).getOutstandingBalance();
        }
        return _outstandingCapital;
    }

    function getProjectedEarnings() view external returns (uint256 _earnedAmount, uint256 _latestDate){
        for(uint256 x = 0; x < outstandingLoans.length; x++) {
            _earnedAmount += IFGBLoan(outstandingLoans[x]).getConditions().interest; 
            uint256 expiryDate_ = IFGBLoan(outstandingLoans[x]).getConditions().expiryDate; 
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

        IFGBLoan.LoanBasis memory loanBasis_ = IFGBLoan.LoanBasis({
                                                borrower        :  msg.sender.toHexString(),
                                                borrowerAddress : msg.sender, 
                                                collateral      : collateral_,
                                                loanAmount      :  _loanAmount,
                                                dealBasis       : _collateralDeals, 
                                                greenFilNft     : _greenFilNftContract, 
                                                greenFilNftId   : _greenFilNftId,
                                                createDate      : block.timestamp
                                                });
        IFGBLoan.LoanConditions memory loanConditions_ = getLoanConditions(loanBasis_, _requestedTerm);

        FGBLoan loan_ = new FGBLoan(self, _minerAddress, loanBasis_, loanConditions_);
        _loanContract =  address(loan_);
        allLoans.push(_loanContract);    
        knownLoan[_loanContract] = true; 
        loanByBorrower[msg.sender] = _loanContract; 
        
        return _loanContract;
    }

    

    function lend(uint256 _maxTerm, uint256 _funds) external payable returns (address _bondContract){
        uint256 coupon_ = getCoupon();
        IFGBGreenBond.BondBasis memory bondBasis_ = IFGBGreenBond.BondBasis ({ 
                                                firstHolder : msg.sender, 
                                                principal : _funds, 
                                                coupon : coupon_,
                                                valueAtMaturity : getValueAtMaturity(_maxTerm, _funds, coupon_),
                                                maturityDate : block.timestamp + _maxTerm, 
                                                initialPenalty : getInitialPenalty(_funds, _maxTerm),
                                                createDate : block.timestamp
                                    });
        FGBGreenBond greenBond_ = new FGBGreenBond(self, bondBasis_);
        
        _bondContract = address(greenBond_);
        outstandingBonds.push(_bondContract);
        knownBond[_bondContract] = true; 
        allBonds.push(_bondContract);
        bondByLender[msg.sender] = _bondContract;

        return _bondContract; 
    }

    function notifyLoanStatusChange(string memory _status) external returns (bool _recieved){
        require(knownLoan[msg.sender], "unknown loan");

        return true; 
    }

    function repatriateFunds(uint256 _funds) external payable returns (bool _repatriated) {
        require(knownLoan[msg.sender], "unknown loan");
        Repatriation memory repatriation_ = Repatriation({
                                                            id : getRepatriationId(),
                                                            loan : msg.sender, 
                                                            amount : _funds,
                                                            repatriationDate : block.timestamp
                                                        });
        repatriationIds.push(repatriation_.id);
        knownRepatriationId[repatriation_.id] = true; 
        repatriationIdsByLoan[msg.sender].push(repatriation_.id);
        repatriationById[repatriation_.id] = repatriation_; 
        return true; 
    }

    function requestActivation() external returns (bool _activated) {
        require(knownLoan[msg.sender], "unknown loan");
        IFGBLoan loan_ = IFGBLoan(msg.sender);
        loan_.credit{value : loan_.getBasis().loanAmount}();
        return true; 
    }
    // ============================= INTERNAL ======================================================================

    function getCoupon() view internal returns (uint256 _coupon) {

    }

    function getValueAtMaturity(uint256 _maxTerm, uint256 _funds, uint256 _coupon) view internal returns (uint256 _valueAtMaturity) {

    }

    function getInitialPenalty(uint256 _funds, uint256 _term) view internal returns (uint256 _penalty) {

    }


    function getRepatriationId() internal returns (uint256 _id) {
        _id = repatriationIndex;
        repatriationIndex++; 
        return _id; 
    }

    function getLoanConditions(IFGBLoan.LoanBasis memory loanBasis_, uint256 _requestedTerm) view internal returns (IFGBLoan.LoanConditions memory _conditions) {
            return IFGBLoan.LoanConditions({               
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