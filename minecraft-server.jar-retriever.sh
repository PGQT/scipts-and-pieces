#!/bin/bash

# Step 1: Fetch the webpage content with a user-agent string
page_content=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" https://www.minecraft.net/en-us/download/server)

# Step 2: Extract the download link (searching for the specific structure in the <a> tag)
download_link=$(echo "$page_content" | grep -oP '(?<=href=")https://piston-data\.mojang\.com/v1/objects/[a-f0-9]+/server\.jar')

# Step 3: Extract the version number from the page content (only the first match)
version=$(echo "$page_content" | grep -oP 'minecraft_server\.\K[0-9]+\.[0-9]+\.[0-9]+' | head -1)

# Step 4: Print the version number and download the .jar file to a directory named after the version number
if [ -n "$download_link" ] && [ -n "$version" ]; then
    echo "Minecraft Server Version: $version"
    
    # Create a directory named after the version number
    mkdir -p "$version"
    
    # Download the .jar file into the directory
    wget -O "$version/minecraft_server.jar" "$download_link"
    
    echo "Downloaded minecraft_server.jar to $(pwd)/$version/"
else
    echo "Download link or version number not found"
fi
