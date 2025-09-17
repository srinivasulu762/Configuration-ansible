#!/bin/bash

# ====== Config ======
SSH_USER="ec2-user"  # ✅ Fix typo from ec2_user if that's what your instance uses
KEY_PATH="$HOME/.ssh/id_rsa.pub"
HOST_FILE="hosts.txt"
SSH_PORT=22


# ====== Loop over hosts ======
for host in $(cat "$HOST_FILE"); do
    echo "🔐 Copying key to $SSH_USER@$host..."
    
    ssh-copy-id -i "$KEY_PATH" -p $SSH_PORT "$SSH_USER@$host"

    if [ $? -eq 0 ]; then
        echo "✅ Success: $host"
    else
        echo "❌ Failed: $host"
    fi
done
