// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/Zondax/fevm-solidity-mock-api/blob/7ad2f617a6a69303aab5c73ebc3690e2e2a57336/contracts/v0.8/MinerAPI.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/99589794db43c8b285f5b3464d2e0864caab8199/contracts/utils/Strings.sol";
import "../interfaces/IFGBLoan.sol";
import "../interfaces/IFGBLoanManager.sol";


contract FGBLoan  is IFGBLoan { 

    using Strings for address; 

    address self; 
    LoanBasis basis; 
    LoanConditions conditions; 
    IFFLoanManager loanManager; 
    MinerAPI miner; 
    bool credited; 
    bool drawnDown; 
    bool cancelled; 
    Repayment [] repayments; 
    DrawDownTx drawDownTx; 

    constructor(address _loanManagerAddress, 
                address _miner, 
                LoanBasis memory _basis, 
                LoanConditions memory _conditions) {
        loanManager = IFFLoanManager(_loanManagerAddress);
        basis = _basis; 
        conditions = _conditions; 
        miner = MinerAPI(_miner);
        self = address(this);
    }

    function getConditions() view external returns (LoanConditions memory _conditions){
        return conditions; 
    }

    function getBasis() view external returns (LoanBasis memory _basis){
        return basis; 
    }

    function getRepayments() view external returns (Repayment [] memory _repayments){
        return repayments; 
    }

    function getDrawDownTx() view external returns(DrawDownTx memory _drawDown){
        return drawDownTx;
    }

    function getOutstandingBalance() view external returns (uint256 _balance) {
        return getOutstandingBalanceInternal();
    }

    function isCredited() view external returns (bool _credited) {
        return credited; 
    }

    function credit() external payable returns (uint256 _balance) {
        require(msg.sender == address(loanManager), "lending pool only");
        credited = true;
        return getBalanceInternal(); 
    }

    function repay(uint256 _repayment) external payable returns (uint256 _outstandingBalance){   
        require(_repayment == msg.value, " value transmission mis-match");
        require(_repayment > conditions.minimumRepayment, " insufficient repayment ");               
        Repayment memory repayment_ = Repayment({
                                                amount : _repayment, 
                                                date :block.timestamp,
                                                payer : msg.sender
                                        });
        repayments.push(repayment_);        
        _outstandingBalance = getOutstandingBalanceInternal();        
        uint256 repatriationAmount_ = _repayment;
        if(_outstandingBalance == 0) {
            uint256 refunded_; 
            (refunded_, repatriationAmount_) = refundChange();
            cancelInternal();
        }
        require(loanManager.repatriateFunds{value : repatriationAmount_}(repatriationAmount_), " unable to credit market");
        return _outstandingBalance; 
    }

    function drawDown() external returns (uint256 _payoutAmount) {
        onlyBorrower();
        require(!cancelled, "loan cancelled");
        require(!drawnDown, "already drawn down");   
        require(beneficiaryAssigned(), "loan not assigned beneficiary");
        drawnDown = true;
        require(loanManager.requestActivation(), "unable to activate"); 
        _payoutAmount = basis.loanAmount; 
        drawDownTx = DrawDownTx({
            amount : _payoutAmount, 
            date : block.timestamp,  
            drawer : msg.sender
        });
        payable(msg.sender).transfer(_payoutAmount);
        return _payoutAmount; 
    }

    function cancel() external returns (bool _cancelled){  
        return cancelInternal(); 
    }

    // ============================ INTERNAL ===========================================
    // check if the loan has been assigned as beneficiary
    function beneficiaryAssigned() view internal returns (bool _isAssigned) {
        return isEqual(self.toHexString(), miner.get_beneficiary().active.beneficiary);        
    }

    function isEqual(string memory a, string memory b) pure internal returns (bool){
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b)))); 
    }

    function cancelInternal() internal returns (bool _cancelled) {
      if(!drawnDown) { 
            // cancel the loan
            cancelled = true;              
        }
        else { 
            require(getOutstandingBalanceInternal() == 0, "balance outstanding");
            cancelled = true; 
            // check the loan has been repaid 
            // then cancel
        }
        return cancelled; 
    }

    // refund any excess
    function refundChange() internal returns (uint256 _refunded, uint256 _tobeRepatriated) {

    }

    function onlyBorrower() view internal returns (bool) {
        require(msg.sender == basis.borrowerAddress, "only borrower");
        return true; 
    }

    function getBalanceInternal() view internal returns (uint256 _balance) {

    }

    function getOutstandingBalanceInternal() view internal returns (uint256 _balance) {

    }

}