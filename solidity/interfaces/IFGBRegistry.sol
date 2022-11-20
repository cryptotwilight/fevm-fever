// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IFGBRegistry { 

    struct VersionedEntry { 
        string name; 
        address veAddress; 
        uint256 version; 
    }


    function getAddress(string memory _name) view external returns (address _address);

    function getName(address _address) view external returns (string memory _name);

    function listConfiguration() view external returns (VersionedEntry [] memory _entries);

}