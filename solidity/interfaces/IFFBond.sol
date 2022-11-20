// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IFFBond {

    struct BondBasis { 
        address firstHolder; 
        uint256 principal; 
        uint256 coupon; 
        uint256 valueAtMaturity; 
        uint256 maturityDate; 
        uint256 initialPenalty; 
        uint256 createDate; 
    }

    function getInitialBasis() view external returns (BondBasis memory _basis);

    function getCurrentHolder() view external returns (address _currentHolder);

    function getMaturityDate() view external returns(uint256 _maturityDate);

    function getValueAtMaturity() view external returns (uint256 _value);

    function getCoupon() view external returns (uint256 _coupon);

    function getPrincipal() view external returns (uint256 _princial);

    function getCurrentValue() view external returns (uint256 _value);    

    function liquidate() external returns (uint256 _payoutAmount, uint256 _penalty);

    function changeHolder(address _newHolder) external returns (bool _ownershipChanged);

}