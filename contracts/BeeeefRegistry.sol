//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";


// ----------------------------------------------------------------------------
// Entries Data Structure
// ----------------------------------------------------------------------------
library Entries {
    struct Entry {
        uint timestamp;
        uint index;
        address account;
        address token;
        uint permission;
    }
    struct Data {
        bool initialised;
        mapping(bytes32 => Entry) entries;
        bytes32[] index;
    }

    event EntryAdded(bytes32 key, address account, address token, uint permission, uint totalAfter);
    event EntryRemoved(bytes32 key, address account, address token, uint totalAfter);
    event EntryUpdated(uint256 indexed tokenId, address account, address token, uint permission);

    function init(Data storage self) internal {
        require(!self.initialised);
        self.initialised = true;
    }
    function generateKey(address account, address token) internal view returns (bytes32 hash) {
        return keccak256(abi.encodePacked(address(this), account, token));
    }
    function hasKey(Data storage self, bytes32 key) internal view returns (bool) {
        return self.entries[key].timestamp > 0;
    }
    function add(Data storage self, address account, address token, uint permission) internal {
        bytes32 key = generateKey(account, token);
        console.log("Entries.add account: %s, token: %s, permission: %s", account, token, permission);
        require(self.entries[key].timestamp == 0);
        self.index.push(key);
        self.entries[key] = Entry(block.timestamp, self.index.length - 1, account, token, permission);
        emit EntryAdded(key, account, token, permission, self.index.length);
    }
    function remove(Data storage self, address account, address token) internal {
        bytes32 key = generateKey(account, token);
        require(self.entries[key].timestamp > 0);
        uint removeIndex = self.entries[key].index;
        emit EntryRemoved(key, account, token, self.index.length - 1);
        uint lastIndex = self.index.length - 1;
        bytes32 lastIndexKey = self.index[lastIndex];
        self.index[removeIndex] = lastIndexKey;
        self.entries[lastIndexKey].index = removeIndex;
        delete self.entries[key];
        if (self.index.length > 0) {
            self.index.pop();
        }
    }

    // function setValue(Data storage self, uint256 tokenId, string memory key, string memory value) internal {
    //     Value storage _value = self.entries[key];
    //     require(_value.timestamp > 0);
    //     _value.timestamp = block.timestamp;
    //     emit AttributeUpdated(tokenId, key, value);
    //     _value.value = value;
    // }
    function length(Data storage self) internal view returns (uint) {
        return self.index.length;
    }
}


contract BeeeefRegistry {

    using Entries for Entries.Data;
    using Entries for Entries.Entry;

    // mapping(address => Entries.Data) private entries;
    Entries.Data private entries;

    string greeting;

    event EntryAdded(bytes32 key, address account, address token, uint permission, uint totalAfter);
    event EntryRemoved(bytes32 key, address account, address token, uint totalAfter);
    event EntryUpdated(uint256 indexed tokenId, address account, address token, uint permission);

    constructor(string memory _greeting) {
        entries.init();
        console.log("Deploying a BeeeefRegistry with greeting:", _greeting);
        greeting = _greeting;
    }

    function addEntry(address token, uint permission) public {
        console.log("addEntry token: %s, permission: %s", token, permission);
        require(token != address(0), "Token cannot be null");
        entries.add(msg.sender, token, permission);
    }

    function removeEntry(address token) public {
        require(token != address(0), "Token cannot be null");
        entries.remove(msg.sender, token);
    }

    function getEntryByIndex(uint i) public view returns (address _account, address _token, uint _permission) {
        require(i < entries.length(), "getEntryByIndex: Invalid index");
        Entries.Entry memory entry = entries.entries[entries.index[i]];
        return (entry.account, entry.token, entry.permission);
    }

    function entriesLength() public view returns (uint) {
        return entries.length();
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}
