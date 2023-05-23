# Level 1 - Fallback

By: Lorenzo Cesconetto

The receive() fallback will set the owner as long as the msg.sender has contributed and msg.value > 0.
Step-by-step solution:

1. Call `contribute()` sending along side some ether (1 wei is enough)
2. Call a low level interaction sending along side some ether, it'll trigger the receive
    - The function will check that you have sent some ether here as well (`msg.value > 0`)
3. Call `withdraw()` to get your ether back
