# Automate Minecraft server update

Based on tutorial at [https://pimylifeup.com/ubuntu-minecraft-bedrock-server/](https://pimylifeup.com/ubuntu-minecraft-bedrock-server/).

This script assumes the exact same file placement and naming conventions used in the tutorial. Additionally, you may need to update paths to your files, and/or remove the backup copy logic if you don't have an allow list for example.

## TODO

[ ] Make checks for copying backup files

[ ] Create variables for paths

## Requirements

You will need the [jq library](https://jqlang.org/) to extract the download URL

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
