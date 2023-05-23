# Level 12 - Privacy

By: Lorenzo Cesconetto

You can use a tool called to `sol2uml` to see the layout of the storage:

```
sol2uml storage -c <contract_name> <file_path>
```

In our case:

```
sol2uml storage -c Privacy ./level_12.sol
```

By looking at the storage layout at [level_12.svg](./level_12.svg), we can see that the data we need is at the `5` slot.

Then to read the storage slot just use the following JS snippet passing the `address` and `slot number`:

```
web3.eth.getStorageAt("0x12345...6789", 5)
```

Note this code in the contract `require(_key == bytes16(data[2]));`
casting will grab the 16 left most bytes, so just grab the first 16 bytes of the result you got from reading the storage slot.
