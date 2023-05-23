# Level 6 - Delegation

By: Lorenzo Cesconetto

The first four bytes of the hash of the function signature is its method id.
To obtain it, we can just run: `web3.utils.sha3("pwn()")`.
Then we just need to call a low level interaction with the msg.data: `0xdd365b8b`.

You may need to **manually adjust the gas limit up**, otherwise your transaction may fail.
