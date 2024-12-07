# Automate Minecraft server update

Based on tutorial at [https://pimylifeup.com/ubuntu-minecraft-bedrock-server/](https://pimylifeup.com/ubuntu-minecraft-bedrock-server/)

## Copy file to server

```bash
scp -r /path/to/mcupdate.sh user@host:/server/path/to/mcupdate.sh
```

## Make file executable

```bash
chmod 755 /path/to/mcupdate.sh
```

## Create bash alias

On the Ubuntu server, add the following to your .bashrc file

```bash
alias mcupdate='sudo bash /path/to/mcupdate.sh'
```
