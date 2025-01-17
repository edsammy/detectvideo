#!/bin/bash

cd ~/desktop
echo "checking for previous versions of motionPlayer..."
if [ -a ~/desktop/motionPlayer/motionPlayer.app ]
    then
    echo "removing previous version..."
    rm -r ~/desktop/motionPlayer/motionPlayer.app
fi
echo "checking directories..."
if [ -d ~/desktop/motionPlayer ]
    then
    echo "main directory exists..."
else
    echo "creating main directory..."
    mkdir motionPlayer
fi
cd motionPlayer
if [ -d ~/desktop/motionPlayer/videos ]
    then
    echo "videos folder exists..."
else
    echo "creating videos directory..."
    mkdir videos
fi
echo "checking if VLC player is installed..."
if [ -a /Applications/VLC.app ] # check if file exists
    then
    echo "VLC already installed, skipping download..."
else
    echo "downloading VLC media player..."
    curl -O http://mirror.de.leaseweb.net/videolan/vlc/2.2.1/macosx/vlc-2.2.1.dmg && \
    hdiutil attach -quiet vlc-2.2.1.dmg && \
    cd /Volumes/vlc-2.2.1 && \
    echo "copying VLC into Applications folder..."
    cp -R VLC.app Applications
fi
cd ~/desktop/motionPlayer
echo "editing VLC settings file..."
curl -O --silent https://raw.githubusercontent.com/edsammy/motionPlayer/master/vlcrc && \
if [ -d ~/Library/Preferences/org.videolan.vlc ] # check if directory exists
    then
    echo "VLC settings folder already exists..."
else
    echo "creating VLC settings folder..."
    #echo "enter password to create folder..."
    mkdir ~/Library/Preferences/org.videolan.vlc
fi
cp vlcrc ~/Library/Preferences/org.videolan.vlc
echo "downloading motionPlayer.zip..."
curl -O https://raw.githubusercontent.com/edsammy/motionPlayer/master/motionPlayer.zip
echo "unzipping app..."
unzip -q motionPlayer.zip # unzip quietly
echo "cleaning up..."
cd /Volumes && \
hdiutil detach -quiet vlc-2.2.1
cd ~/desktop/motionPlayer
rm vlc-2.2.1.dmg
rm vlcrc
rm motionPlayer.zip
if [ -a /Library/PreferencePanes/JavaControlPanel.prefpane ] # check if JRE is installed
    then
    echo "complete!"
else
    echo "***** setup not complete! ******"
    echo "You must install the Java Runtime Environment (JRE) in order to run the MotionPlayer"
    echo "Please install from http://www.java.com/en/download before running the MotionPlayer."
fi