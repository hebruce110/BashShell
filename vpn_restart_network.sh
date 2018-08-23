#!/bin/bash
# Change IFACE to match your WiFi interface 
# (en0 on Macbook Air and Retina, en1 on old Macbook Pros with ethernet) 
# refer link http://blog.csdn.net/doc_sgl/article/details/49835069
sudo ifconfig en0 down
sudo route flush
sudo ifconfig en0 up