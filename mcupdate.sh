#!/bin/bash

####################################
# AUTO UPDATE MINECRAFT
# based on tutorial at https://pimylifeup.com/ubuntu-minecraft-bedrock-server/

# copy file to server: scp -r /path/to/mcupdate.sh user@host:/server/path/to/mcupdate.sh
# chmod 755 /path/to/mcupdate.sh (make file executable)
# alias mcupdate='sudo bash /path/to/mcupdate.sh' (add to bash aliases on ubuntu server)
####################################

# CHECK REQUIREMENTS
if ! command -v jq &> /dev/null
  then
    echo "Error: jq library not installed. Please install and try again."
    exit 1
fi

# STOP SERVER
echo stopping server ...
sudo systemctl stop mcbedrock

# COPY BACKUP FILES for server properties AND allowlist
echo backing up files ...
sudo cp /home/mcserver/minecraft_bedrock/server.properties /home/mcserver/server.properties.bkup

sudo cp /home/mcserver/minecraft_bedrock/allowlist.json /home/mcserver/allowlist.json

ls -al /home/mcserver/

# DOWNLOAD new version
echo downloading new version ...
DOWNLOAD_URL="$(curl -s https://net-secondary.web.minecraft-services.net/api/v1.0/download/links | jq -r '.result.links[] | select(.downloadType=="serverBedrockLinux") | .downloadUrl')"

sudo wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; BEDROCK-UPDATER)" $DOWNLOAD_URL -O /home/mcserver/minecraft_bedrock/bedrock-server.zip

ls -al /home/mcserver/minecraft_bedrock/

# UNZIP file/extract archive
echo extracting files ...
sudo unzip -o /home/mcserver/minecraft_bedrock/bedrock-server.zip -d /home/mcserver/minecraft_bedrock/

# REMOVE zip file
echo removing download ...
sudo rm /home/mcserver/minecraft_bedrock/bedrock-server.zip

# COPY BACKUP FILES to new version
echo copying backup files ...
sudo mv /home/mcserver/server.properties.bkup /home/mcserver/minecraft_bedrock/server.properties

sudo mv /home/mcserver/allowlist.json /home/mcserver/minecraft_bedrock/allowlist.json

ls -al /home/mcserver/minecraft_bedrock/

# SET OWNERSHIP of directory
echo setting ownership ...
sudo chown -R mcserver:mcserver /home/mcserver/

# START SERVER
echo restarting server ...
sudo systemctl start mcbedrock

sudo systemctl status mcbedrock
