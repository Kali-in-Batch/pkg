#!/bin/bash

# Check if the Windows Subsystem for Linux (WSL) is installed
wsl --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: WSL is not installed. Please install WSL before running this Kali in Batch package."
    echo "Do you want to install WSL? (y/n)"
    read -p "Enter your choice: " choice
    if [ "$choice" == "y" ]; then
        echo "Installing WSL..."
        wsl --install
        echo "Exiting..."
        exit 0
    else
        echo "Exiting..."
        exit 1
    fi
    exit 1
else
    echo "You can run executables that are in the current directory, for example if you want to run busybox and have it in current directory, you can run: ./busybox <applet>"
    printf "elf-exec>> "
    # Wait for user to input a path
    read -p "" path
    # Run the executable
    wsl sh -c "${path} && exit"
    exit 0
fi
