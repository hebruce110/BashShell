#!/bin/sh
#Ubuntu16.04

# Install RabbitMQ signing key
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -

# Install apt HTTPS transport
sudo apt-get install apt-transport-https

# Add Bintray repositories that provision latest RabbitMQ and Erlang 21.x releases
sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
deb http://dl.bintray.com/rabbitmq-erlang/debian xenial erlang
deb https://dl.bintray.com/rabbitmq/debian xenial main
EOF

# Update package indices
sudo apt-get update -y

# Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing

# Start RabbitMQ Server
# sudo service rabbitmq-server start

# RabbitMQ Server Status
# sudo service rabbitmq-server status

# Stop RabbitMQ Server
# sudo service rabbitmq-server stop