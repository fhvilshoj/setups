# VPN Access to AU vpn

I have been struggeling a bit with AU-vpn. However, I believe that I have finally found a way to do it. 
First of all, [this link](https://medarbejdere.au.dk/fileadmin/www.medarbejdere.au.dk/Medarbejderservice/IT/Medarbejderservice_AU_IT/VPN_-_remote.au.dk/VPN_Manual_-_Ubuntu_-_Engelsk.pdf) helps setting it up. Note that it is **AU-ACCESS** that need to be used and not ST.

When setup, the next thing to do is to start the Cisco VPN client:

```python
> /opt/cisco/anyconnect/bin/vpnui
```

Then there should pop open a window, where the flow is as follows:

![Enter remote `remote.au.dk`](./imgs/first.png)

![Sign in with Au credentials: `au[0-9]{6}@uni.au.dk`](./imgs/second.png)
