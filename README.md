# BeeeefRegistry

The Beeeef Registry is a [smart contract](deployed/BeeeefRegistry_deployed_v1_to_0xBeEEeFEE77863fe2333da3b4679e4CC126341b81.sol) deployed to the Ethereum blockchain to [0xBeEEeFEE77863fe2333da3b4679e4CC126341b81](https://etherscan.io/address/0xBeEEeFEE77863fe2333da3b4679e4CC126341b81#code), or [beeeefregistry.nftpostcard.eth](https://app.ens.domains/name/beeeefregistry.nftpostcard.eth).

This registry allows accounts to cryptographically sign for the account's NFTs media (JPGs, PNGs, ...) to be available for personal use by members of the public. The permissions can either be **View** for the media to be displayed/played or **ComposeWith** for the media to be re-mixed in digital media for personal use.

<br />

### Sample Entries

account  | token | permission | curation
:------- |:----- |:---------- |:--------
0xOwner1 | address(0) | View | LoadByDefault
0xOwner1 | 0xTokenA | ComposeWith | LoadByDefault
0xOwner2 | address(0) | ComposeWith | None
0xOwner2 | 0xTokenA | View | None
0xOwner3 | address(0) | ComposeWith | None
0xOwner3 | 0xTokenB | View | None

The first three columns can only by updated by the owner accounts and the last column by the curator.

<br />

<hr />

## Registry Functions

Registry functions have the parameters with values currently used in the user interface [https://nftpostcard.app/](https://nftpostcard.app/):

* `address account`: NFT owner account
* `address token`: ERC-721 or ERC-1155 token contract address, or `address(0)` of all token contracts
* Permission: 0 = None; 1 = View; 2 = ComposeWith
* Curation: 0 = None; 1 = LoadByDefault; 3 = DisableView; 4 = DisableComposeWith

If there are more than two matching entries for an owner's `[account, token]`, the most specific match takes precedent. i.e., the permission for `[account, token]` is applied if it exist. If no match if found, the permission for `[account, address(0)]` is applied.

<br />

### Add Entry

```javascript
function addEntry(address token, Permission permission) public;
```

Executing `addEntry(...)` from an NFT owner account adds an entry into this registry. `token` can bet set to `address(0)` to permission all token contracts. `permission` should be set to 0 = None; 1 = View; or 2 = ComposeWith.

<br />

### Remove Entry

```javascript
function removeEntry(address token) public;
```

Executing `removeEntry(...)` from an NFT owner account removes an existing entry from this registry. `token` can bet set to `address(0)` or a specific token contract address.

<br />

### Update Entry

```javascript
function updateEntry(address token, Permission permission) public;
```

Executing `updateEntry(...)` from an NFT owner account updates an existing entry in this registry. `token` can bet set to `address(0)` to permission all token contracts. `permission` should be set to 0 = None; 1 = View; or 2 = ComposeWith.

<br />

### Curate Entry

```javascript
function curateEntry(address account, address token, Curation curation) public onlyCurator;
```

The curator of this registry (deployer of the registry, currently) is able to apply the following setting to any `[account, token]` pair (including token `address(0)`) - 0 = None; 1 = LoadByDefault; 3 = DisableView; 4 = DisableComposeWith . This setting is used by the front end user interface to determine which entries are automatically loaded, manually loadable, or disabled from display.

<br />

<hr />

## Token Contract Reference

### BASTARD GAN PUNKS V2 - 'ComposeWith'

* Site: [https://www.bastardganpunks.club/](https://www.bastardganpunks.club/)
* Image licence: [https://www.bastardganpunks.club/#nftownership](https://www.bastardganpunks.club/#nftownership)
* Contract: [0x31385d3520bCED94f77AaE104b406994D8F2168C](https://etherscan.io/address/0x31385d3520bCED94f77AaE104b406994D8F2168C) @ [Mar-07-2021 12:03:56 PM +UTC](https://etherscan.io/tx/0xd875fb294bf841eaf7bffae94bd5488d78f227e9b4a3017105bae31b296419ce)
* OpenSea: [https://opensea.io/collection/bastard-gan-punks-v2](https://opensea.io/collection/bastard-gan-punks-v2)

<br />

### Bonsai by ZENFT - 'ComposeWith'

* Site: [https://zenft.xyz/](https://zenft.xyz/)
* Image licence: [https://zenft.xyz/#welcome](https://zenft.xyz/#welcome)
* Contract: [0xeC9C519D49856Fd2f8133A0741B4dbE002cE211b](https://etherscan.io/address/0xeC9C519D49856Fd2f8133A0741B4dbE002cE211b) @ [May-27-2021 02:15:51 AM +UTC](https://etherscan.io/tx/0xa8d97e619389366eaca8460074ee32f6c1752f389c34eb40b489486f0a048af8)
* OpenSea: [https://opensea.io/collection/bonsai-zenft](https://opensea.io/collection/bonsai-zenft)


<br />

### Bored Ape Yacht Club - 'ComposeWith'

* Site: [https://boredapeyachtclub.com/](https://boredapeyachtclub.com/)
* Image licence: [https://boredapeyachtclub.com/#/terms](https://boredapeyachtclub.com/#/terms)
* Contract: [0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D](https://etherscan.io/address/0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D) @ [Apr-22-2021 03:03:16 AM +UTC](https://etherscan.io/tx/0x22199329b0aa1aa68902a78e3b32ca327c872fab166c7a2838273de6ad383eba)
* OpenSea: [https://opensea.io/collection/boredapeyachtclub](https://opensea.io/collection/boredapeyachtclub)

<br />

### CryptoCats - 'ComposeWith' for 477 Only

* Site: [https://cryptocats.thetwentysix.io/](https://cryptocats.thetwentysix.io/)
* Image licence: "Approval from CryptoCats to use 477 on NFT postcards" - gendry.eth Jun 4 2021
* Contract: Official Wrapped - [0xd0e7bc3f1efc5f098534bce73589835b8273b9a0](https://etherscan.io/address/0xd0e7bc3f1efc5f098534bce73589835b8273b9a0) @ [Mar-14-2021 05:38:56 PM +UTC](https://etherscan.io/tx/0xc8cd4eabd30ce7ada26fb06066a95d6bb4feb21e5885fadcf5e5560e3341ec4c); Original - [0x088C6Ad962812b5Aa905BA6F3c5c145f9D4C079f](https://etherscan.io/address/0x088C6Ad962812b5Aa905BA6F3c5c145f9D4C079f) @ [Dec-24-2017 02:10:09 PM +UTC](https://etherscan.io/tx/0xa38a7f8bd386cca288af2fe3d15f7b0d91d52a849e81e18022ad4a901816e2a5)
* OpenSea: [https://opensea.io/collection/wrappedcryptocats](https://opensea.io/collection/wrappedcryptocats)

<br />

### CryptoPunks - ? 'ComposeWith'

* Site: [https://www.larvalabs.com/cryptopunks](https://www.larvalabs.com/cryptopunks)
* Image licence: Not found
* Contract: Wrapped - [0xb7f7f6c52f2e2fdb1963eab30438024864c313f6](https://etherscan.io/address/0xb7f7f6c52f2e2fdb1963eab30438024864c313f6) @ [Sep-08-2020 03:11:25 PM +UTC](https://etherscan.io/tx/0xe55761b300a9370da47488715715e249245fddb2540d7d0a0db33192142a4287); Original - [0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB](https://etherscan.io/address/0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB) @ [Jun-22-2017 07:40:00 PM +UTC](https://etherscan.io/tx/0x0885b9e5184f497595e1ae2652d63dbdb2785de2e498af837d672f5765f28430)
* OpenSea: Wrapped - [https://opensea.io/assets/wrapped-cryptopunks](https://opensea.io/assets/wrapped-cryptopunks)

<br />

### CryptoTrunks - ? 'ComposeWith'

* Site: [https://cryptotrunks.co/](https://cryptotrunks.co/)
* Image licence: Not found
* Contract: [0x375ea781c49EaFEdDE07AFe6196f885761f166Ae](https://etherscan.io/address/0x375ea781c49EaFEdDE07AFe6196f885761f166Ae) @ [May-16-2021 02:08:01 AM +UTC](https://etherscan.io/tx/0x40ff75cd71f8c220db8c199c28d744b00aecb50376413959f8f74cd972af85c6)
* OpenSea: [https://opensea.io/collection/cryptotrunks](https://opensea.io/collection/cryptotrunks)

<br />

### Hashmasks - 'ComposeWith'

* Site: [https://www.thehashmasks.com/](https://www.thehashmasks.com/)
* Image licence: [https://www.thehashmasks.com/terms](https://www.thehashmasks.com/terms)
* Contract: [0xC2C747E0F7004F9E8817Db2ca4997657a7746928](https://etherscan.io/address/0xC2C747E0F7004F9E8817Db2ca4997657a7746928) @ [Jan-28-2021 10:21:43 AM +UTC](https://etherscan.io/tx/0xe9e60dc12e1a7bc545aa497bc494f5f54ce81da06de4f6fef50459816218e66b)
* OpenSea: [https://opensea.io/collection/hashmasks](https://opensea.io/collection/hashmasks)


<br />

### Mandalas - 'ComposeWith'

* Site: [https://mandalas.eth.link/](https://mandalas.eth.link/)
* Image licence: Algorithmically generated
* Contract: [0xDaCa87395f3b1Bbc46F3FA187e996E03a5dCc985](https://etherscan.io/address/0xDaCa87395f3b1Bbc46F3FA187e996E03a5dCc985) @ [Mar-21-2021 04:16:17 PM +UTC](https://etherscan.io/tx/0xa5c096a1c149fa603c300ef32da8eed342489e39cca3f110a6f733c5f7f36a6e)
* OpenSea: [https://opensea.io/collection/mandala-tokens](https://opensea.io/collection/mandala-tokens)

<br />

### Meebits - 'View'

* Site: [https://meebits.larvalabs.com/](https://meebits.larvalabs.com/)
* Image licence: Commercial use < $100,000 - [https://meebits.larvalabs.com/meebits/termsandconditions](https://meebits.larvalabs.com/meebits/termsandconditions)
* Contract: [0x7Bd29408f11D2bFC23c34f18275bBf23bB716Bc7](https://etherscan.io/address/0x7Bd29408f11D2bFC23c34f18275bBf23bB716Bc7) @ [May-03-2021 12:49:32 AM +UTC](https://etherscan.io/tx/0xf2040b9b67193fe8c861a18cff864b9f35c1f69cc8734c724c388c449a1116c4)
* OpenSea: [https://opensea.io/collection/meebits](https://opensea.io/collection/meebits)

<br />

### MoonCats - 'ComposeWith'

* Site: [https://mooncat.community/](https://mooncat.community/)
* Image licence: Algorithmically generated - [https://github.com/ponderware/mooncatparser](https://github.com/ponderware/mooncatparser)
* Contract: Acclimated - [0xc3f733ca98E0daD0386979Eb96fb1722A1A05E69](https://etherscan.io/address/0xc3f733ca98E0daD0386979Eb96fb1722A1A05E69); Original [0x60cd862c9C687A9dE49aecdC3A99b74A4fc54aB6](https://etherscan.io/address/0x60cd862c9C687A9dE49aecdC3A99b74A4fc54aB6) @ [Aug-09-2017 04:36:06 AM +UTC](https://etherscan.io/tx/0x79d48c41b99f0ac8f735dbf4d048165542576862df2b05a80be9a4dbe233a623)
* OpenSea: [https://opensea.io/collection/acclimatedmooncats](https://opensea.io/collection/acclimatedmooncats)

<br />

### The Pixel Portraits - ?'ComposeWith'

* Site: [https://www.thepixelportraits.me/](https://www.thepixelportraits.me/)
* Image licence: Check with creators - [https://www.thepixelportraits.me/terms](https://www.thepixelportraits.me/terms)
* Contract: OpenSea Shared Storefront [0x495f947276749Ce646f68AC8c248420045cb7b5e](https://etherscan.io/address/0x495f947276749Ce646f68AC8c248420045cb7b5e)
* OpenSea: [https://opensea.io/collection/the-pixel-portraits](https://opensea.io/collection/the-pixel-portraits)

<br />

### PunkBodies - 'ComposeWith'

* Site: [https://www.punkbodies.com/](https://www.punkbodies.com/)
* Image licence: Commercial use < $100,000 - [https://docs.google.com/document/d/e/2PACX-1vTArGo--JUzHYfqw9rDBxCWmrGX4aQKtpnGHCCy2-mu94QC4lKqsflmmP6JtCD_HU40s_rCjJj6LxR4/pub](https://docs.google.com/document/d/e/2PACX-1vTArGo--JUzHYfqw9rDBxCWmrGX4aQKtpnGHCCy2-mu94QC4lKqsflmmP6JtCD_HU40s_rCjJj6LxR4/pub)
* Contract: [0x837779Ed98209C38b9bF77804a4f0105B9eb2E02](https://etherscan.io/address/0x837779Ed98209C38b9bF77804a4f0105B9eb2E02) @ [Mar-27-2021 02:42:45 PM +UTC](https://etherscan.io/tx/0xbcb3e08d818d6e9411d879d4ad854fd0f4f2de260e53f69fa7e71f0f0c7fe583)
* OpenSea: [https://opensea.io/collection/punkbodies](https://opensea.io/collection/punkbodies)

<br />

<br />

Enjoy!

(c) BokkyPooBah / Bok Consulting Pty Ltd - Jun 10 2021. The MIT Licence.
