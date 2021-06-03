//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// ----------------------------------------------------------------------------
// Curated contract
// ----------------------------------------------------------------------------
contract Curated {
    address public curator;

    event CuratorTransferred(address indexed _from, address indexed _to);

    modifier onlyCurator {
        require(msg.sender == curator);
        _;
    }

    constructor() {
        curator = msg.sender;
    }
    function transferCurator(address _newCurator) public onlyCurator {
        emit CuratorTransferred(curator, _newCurator);
        curator = _newCurator;
    }
}


// ----------------------------------------------------------------------------
// Entries Data Structure
// ----------------------------------------------------------------------------
library Entries {
    struct Entry {
        uint index;
        uint64 timestamp;
        address account;
        address token;
        uint32 permission;
        uint32 curatorOption;
    }
    struct Data {
        bool initialised;
        mapping(bytes32 => Entry) entries;
        bytes32[] index;
    }

    event EntryAdded(bytes32 key, address account, address token, uint permission, uint totalAfter);
    event EntryRemoved(bytes32 key, address account, address token, uint totalAfter);
    event EntryUpdated(bytes32 key, address account, address token, uint permission);
    event EntryCurated(bytes32 key, address account, address token, uint curatorOption);

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
    function add(Data storage self, address account, address token, uint32 permission) internal {
        bytes32 key = generateKey(account, token);
        // console.log("Entries.add account: %s, token: %s, permission: %s", account, token, permission);
        require(self.entries[key].timestamp == 0);
        self.index.push(key);
        self.entries[key] = Entry(self.index.length - 1, uint64(block.timestamp), account, token, permission, 0);
        emit EntryAdded(key, account, token, permission, self.index.length);
    }
    function remove(Data storage self, address account, address token) internal {
        bytes32 key = generateKey(account, token);
        require(self.entries[key].timestamp > 0);
        // Not required? Hash should mismatch
        // require(self.entries[key].account == msg.sender);
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
    function update(Data storage self, address account, address token, uint32 permission) internal {
        bytes32 key = generateKey(account, token);
        Entry storage entry = self.entries[key];
        require(entry.timestamp > 0);
        entry.timestamp = uint64(block.timestamp);
        entry.permission = permission;
        emit EntryUpdated(key, account, token, permission);
    }
    function curate(Data storage self, address account, address token, uint32 curatorOption) internal {
        bytes32 key = generateKey(account, token);
        Entry storage entry = self.entries[key];
        require(entry.timestamp > 0);
        entry.curatorOption = curatorOption;
        emit EntryCurated(key, account, token, curatorOption);
    }
    function length(Data storage self) internal view returns (uint) {
        return self.index.length;
    }
}


contract BeeeefRegistry is Curated {

    using Entries for Entries.Data;
    using Entries for Entries.Entry;

    Entries.Data private entries;

    event EntryAdded(bytes32 key, address account, address token, uint permission, uint totalAfter);
    event EntryRemoved(bytes32 key, address account, address token, uint totalAfter);
    event EntryUpdated(bytes32 key, address account, address token, uint permission);
    event EntryCurated(bytes32 key, address account, address token, uint curatorOption);

    constructor() {
        entries.init();
    }

    function addEntry(address token, uint32 permission) public {
        // console.log("addEntry token: %s, permission: %s", token, permission);
        require(token != address(0), "Token cannot be null");
        entries.add(msg.sender, token, permission);
    }

    function removeEntry(address token) public {
        require(token != address(0), "Token cannot be null");
        entries.remove(msg.sender, token);
    }
    function updateEntry(address token, uint32 permission) public {
        // console.log("addEntry token: %s, permission: %s", token, permission);
        require(token != address(0), "Token cannot be null");
        entries.update(msg.sender, token, permission);
    }

    function curateEntry(address account, address token, uint32 curatorOption) public onlyCurator {
        entries.curate(account, token, curatorOption);
    }

    function getEntryByIndex(uint i) public view returns (address _account, address _token, uint _permission) {
        require(i < entries.length(), "getEntryByIndex: Invalid index");
        Entries.Entry memory entry = entries.entries[entries.index[i]];
        return (entry.account, entry.token, entry.permission);
    }

    function entriesLength() public view returns (uint) {
        return entries.length();
    }

    function getEntries() public view returns (address[] memory accounts, address[] memory tokens, uint32[] memory permissions, uint32[] memory curatorOptions) {
        uint length = entries.length();
        accounts = new address[](length);
        tokens = new address[](length);
        permissions = new uint32[](length);
        curatorOptions = new uint32[](length);
        for (uint i = 0; i < length; i++) {
            Entries.Entry memory entry = entries.entries[entries.index[i]];
            accounts[i] = entry.account;
            tokens[i] = entry.token;
            permissions[i] = entry.permission;
            curatorOptions[i] = entry.curatorOption;
        }
    }
}
