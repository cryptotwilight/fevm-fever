// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/IFGBGreenBond.sol";
import "../interfaces/IFGBLendingMarket.sol";

contract FGBGreenBond is IFGBGreenBond { 

    address holder; 
    BondBasis basis; 
    IFFLendingMarket lendingMarket; 
    

    constructor(address _lendingMarket, BondBasis memory _basis) {
        holder = basis.firstHolder; 
        basis = _basis; 
        lendingMarket = IFFLendingMarket(_lendingMarket);        
    }

    function getInitialBasis() view external returns (BondBasis memory _basis){
        return basis; 
    }

    function getNotionalPenalty() view external returns (uint256 _penalty) {
        return calculatePenalty(); 
    }

    function getCurrentHolder() view external returns (address _currentHolder){
        return holder; 
    }

    function getMaturityDate() view external returns(uint256 _maturityDate){
        return basis.maturityDate; 
    }

    function getValueAtMaturity() view external returns (uint256 _value){
        return basis.valueAtMaturity; 
    }

    function getCoupon() view external returns (uint256 _coupon){
        return basis.coupon;
    }

    function getPrincipal() view external returns (uint256 _princial){
        return basis.principal; 
    }

    function getCurrentValue() view external returns (uint256 _value){

    } 

    function liquidate() external returns (uint256 _payoutAmount, uint256 _penalty){

    }

    function changeHolder(address _newHolder) external returns (bool _ownershipChanged){
        require(msg.sender == holder, " holder only ");
        holder = _newHolder; 
        return true;
    }


    //============================== INTERNAL ================================================

    function calculatePenalty() view internal returns (uint256 _penalty) {
        return basis.initialPenalty * (block.timestamp - basis.createDate) / (basis.maturityDate - basis.createDate);
    }

}