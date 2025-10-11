#!/bin/bash

# Greeting
echo "Hello, Linux World!"

# Show current directory
echo "Current Directory:"
pwd

# Show Linux distribution
echo "Linux Distribution:"
cat /etc/os-release | grep PRETTY_NAME

# Show kernel version
echo "Kernel Version:"
uname -r

# List files in current directory
echo "Files in Current Directory:"
ls

# Display help for ls (first 5 lines for brevity)
echo "First few lines of 'man ls':"
man ls | head -n 5
