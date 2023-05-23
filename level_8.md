# Level 8 - Vault

By: Lorenzo Cesconetto

Nothing in the blockchain's storage is private

We can read the password using the following `JS` snippet: `const password = await web3.eth.getStorageAt(contractAddress, storageSlotNumber)`

If you're using the remix, you can run the following JS code directly in the console: `web3.eth.getStorageAt("0xB8FA2FDcE6e916655f82bAc3F3E58b26E04F733e", 1)`
