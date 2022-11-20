// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/IFGBRegistry.sol";
import "../interfaces/IFGBVersionedAddress.sol";

contract FGBRegistry is IFGBRegistry { 

    address administrator; 
    address [] addresses; 
    mapping(address=>bool) hasEntry; 
    mapping(string=>bool) hasVEntry; 
    mapping(address=>VersionedEntry) entryByAddress; 
    mapping(string=>VersionedEntry) entryByName; 

    constructor(address _administrator) {
        administrator = _administrator;
    }

   function getAddress(string memory _name) view external returns (address _address){
       require(hasVEntry[_name], "no entry");
       return entryByName[_name].veAddress; 
   }

   function getName(address _address) view external returns (string memory _name){
       require(hasEntry[_address], "no entry");
       return entryByAddress[_address].name; 
   }
   
   function listConfiguration() view external returns (VersionedEntry [] memory _entries){
       _entries = new VersionedEntry[](addresses.length);
       for(uint256 x = 0; x < addresses.length; x++) {
            _entries[x] = entryByAddress[addresses[x]];
       }
       return _entries; 
   }

    function addVersionedAddress(address _versionedAddress) external returns (bool _added) {
        adminOnly(); 
        IFGBVersionedAddress va = IFGBVersionedAddress(_versionedAddress);
        addVersionedAddressInternal(va.getName(), _versionedAddress, va.getVersion());
        return true; 
    }

    function addNonVersionedAddress(string memory _name, address _address, uint256 _version) external returns (bool _added){
        adminOnly(); 
        addVersionedAddressInternal(_name, _address, _version);
        return true; 
    }

    function removeVersionedAddress(address _versionedAddress) external returns (bool _removed) {
        adminOnly(); 
        addresses = remove(_versionedAddress, addresses); 
        VersionedEntry memory ve_ = entryByAddress[_versionedAddress];
        delete entryByAddress[_versionedAddress];
        delete hasEntry[_versionedAddress]; 
        delete hasVEntry[ve_.name]; 
        delete entryByName[ve_.name]; 
        return true; 
    }

    //====================================== INTERNAL ============================================

    function addVersionedAddressInternal(string memory _name, address _address, uint256 _version)  internal returns (bool _added) {
        addresses.push(_address);
        VersionedEntry memory ve_ = VersionedEntry({
                                                    name : _name, 
                                                    veAddress : _address, 
                                                    version : _version
                                                    });
        entryByAddress[_address] = ve_;
        hasEntry[_address] = true; 
        hasVEntry[_name] = true; 
        entryByName[_name] = ve_; 
        return true; 
    }

    function remove(address _a, address [] memory _b) pure internal returns (address [] memory _c) {
        uint256 e_ = _b.length-1;
        _c = new address[](e_);
        uint256 y = 0; 
        for(uint256 x = 0; x < _b.length; x++) {
            address d_ = _b[x];
            if(_a != d_) {
                if(y == e_){
                    return _b; 
                }
                _c[y]  = d_; 
                y++;
            }
        }
        return _c; 
    }

    function adminOnly() view internal returns (bool ){
        require(msg.sender == administrator, "admin only");
        return true; 
    }

}
