const { expect } = require("chai");

var TESTACCOUNT1 = "0x0000000000000000000000000000000000011111";
var TESTACCOUNT2 = "0x0000000000000000000000000000000000022222";

describe("BeeeefRegistry", function() {

  async function printEntries(contract) {
    const length = await contract.entriesLength();
    console.log("printEntries length: " + length);
    for (let i = 0; i < length; i++) {
      const entry = await contract.getEntryByIndex(i);
      console.log("printEntries " + i + ": " + JSON.stringify(entry));
    }
  }

  it("Should return the new greeting once it's changed", async function() {

    let [ownerSigner, user0Signer] = await ethers.getSigners();

    const Greeter = await ethers.getContractFactory("BeeeefRegistry");
    const greeter = await Greeter.deploy("Hello, world!");

    await greeter.deployed();
    expect(await greeter.greet()).to.equal("Hello, world!");

    const addEntryTx0 = await greeter.addEntry(TESTACCOUNT1, 1);
    await printEntries(greeter);

    const addEntryTx1 = await greeter.addEntry(TESTACCOUNT2, 1);
    await printEntries(greeter);

    const removeEntryTx0 = await greeter.removeEntry(TESTACCOUNT1);
    await printEntries(greeter);

    const removeEntryTx1 = await greeter.removeEntry(TESTACCOUNT2);
    await printEntries(greeter);

    await greeter.setGreeting("Hola, mundo!");
    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
