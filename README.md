This is an unofficial Dockerized I2P within a Debian Jessie image.
I2prouter run from non-root user with save permission

Run with the following:
````
docker run --name i2p_1 -v /home/i2p:/var/lib/i2p --rm -p 4444:4444 -p 7657:7657 -e "HOSTUID=`id -u i2psvc`" -e "HOSTGID=`id -g i2psvc`" ninthgate/i2p-docker
````

i2psvc is user from host machine who own /home/i2p, you can use own user



Publish how many (or how few) ports as you want. Ports exposed by default include

* 2827 — BOB
* 4444 — eepSite proxy
* 6668 — Irc2P proxy
* 7650 — I2PControl
* 7654 — I2CP
* 7655 — SAM (UDP)
* 7656 — SAM (TCP)
* 7657 — Router console
* 7658 — eepSite
* 7659 — SMTP
* 7660 — POP3
* 7661 — I2P-Bote SMTP
* 7662 — I2P-Bote IMAP / Zzzot
* 8998 — Monotone Proxy

