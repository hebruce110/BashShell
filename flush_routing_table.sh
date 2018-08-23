#!/bin/bash
# Flush macos routing table
IFACE=en0
sudo ifconfig $IFACE down
sudo route flush
sudo ifconfig $IFACE up
