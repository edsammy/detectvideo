#!/bin/bash

cd ~
echo "creating directories..."
mkdir motionPlayer && cd motionPlayer
mkdir videos
echo "downloading VLC media player..."
curl -O http://mirror.de.leaseweb.net/videolan/vlc/2.2.1/macosx/vlc-2.2.1.dmg && \
hdiutil attach -quiet vlc-2.2.1.dmg && \
cd /Volumes/vlc-2.2.1 && \
cp -R VLC.app Applications
cd ~/motionPlayer
echo "editing VLC settings file..."
curl -O https://raw.githubusercontent.com/edsammy/cyoung/master/vlrc && \
cp vlrc ~/Library/Preferences/org.videolan.vlc
echo "downloading motionPlayer.app"
curl -O https://raw.githubusercontent.com/edsammy/cyoung/master/motionPlayer.app
echo "cleaning up..."
cd /Volumes
hdiutil detach vlc-2.2.1 && \
cd ~/motionPlayer && \
rm vlc-2.2.1.dmg
echo "complete!"