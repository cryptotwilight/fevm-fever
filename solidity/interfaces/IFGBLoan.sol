// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IFGBLoan {
    struct Repayment { 
        uint256 amount; 
        uint256 date; 
        address payer; 
    }

    struct DrawDownTx { 
        uint256 amount; 
        uint256 date; 
        address drawer;
    }
    struct LoanBasis { 
        string borrower; 
        address borrowerAddress; 
        uint256 collateral;
        uint256 loanAmount; 
        uint256 [] dealBasis; 
        address greenFilNft; 
        uint256 greenFilNftId; 
        uint256 createDate; 
    }

    struct LoanConditions { 
        uint256 interest; 
        uint256 expiryDate; 
        uint256 liquidationFactor; 
        uint256 minimumRepayment; 
    }

    function getConditions() view external returns (LoanConditions memory _conditions);

    function getBasis() view external returns (LoanBasis memory _basis);

    function getOutstandingBalance() view external returns (uint256 _outstandingBalance);

    function getRepayments() view external returns (Repayment [] memory _repayments);

    function getDrawDownTx() view external returns(DrawDownTx memory _drawDown);

    function drawDown() external returns (uint256 _payoutAmount);

    function repay(uint256 _repayment) external payable returns (uint256 _outstandingBalance);

    function cancel() external returns (bool _cancelled);

    // ========== MARKET FUNCTIONS ====================

    function credit() external payable returns (uint256 _balance);
    
}