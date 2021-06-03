const { expect } = require("chai");

var TESTACCOUNT1 = "0x0000000000000000000000000000000000011111";
var TESTACCOUNT2 = "0x0000000000000000000000000000000000022222";

describe("BeeeefRegistry", function() {

  async function printEntries(contract) {
    const entries = await contract.getEntries();
    console.log("printEntries entries: " + JSON.stringify(entries));

    // const length = await contract.entriesLength();
    // console.log("printEntries length: " + length);
    // for (let i = 0; i < length; i++) {
    //   const entry = await contract.getEntryByIndex(i);
    //   console.log("printEntries " + i + ": " + JSON.stringify(entry));
    // }
  }

  it("Should return the new greeting once it's changed", async function() {

    let [ownerSigner, user0Signer] = await ethers.getSigners();

    const BeeeefRegistry = await ethers.getContractFactory("BeeeefRegistry");
    const registry = await BeeeefRegistry.deploy();

    await registry.deployed();
    // expect(await registry.greet()).to.equal("Hello, world!");

    const curator = await registry.curator();
    console.log("curator: " + curator);

    const addEntryTx0 = await registry.connect(user0Signer).addEntry(TESTACCOUNT1, 1);
    await printEntries(registry);

    const addEntryTx1 = await registry.connect(user0Signer).addEntry(TESTACCOUNT2, 6);
    await printEntries(registry);

    const updateEntryTx0 = await registry.connect(user0Signer).updateEntry(TESTACCOUNT2, 7);
    await printEntries(registry);

    const curateEntryTx0 = await registry.connect(ownerSigner).curateEntry(user0Signer.address, TESTACCOUNT2, 7);
    await printEntries(registry);

    const removeEntryTx0 = await registry.connect(user0Signer).removeEntry(TESTACCOUNT1);
    await printEntries(registry);

    const removeEntryTx1 = await registry.connect(user0Signer).removeEntry(TESTACCOUNT2);
    await printEntries(registry);
  });
});
