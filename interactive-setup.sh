#!bin/bash

cat >&2 << EOL
Enter what you want to setup
 1. Kernel
 2. Vim
 3. SSH
 4. QEMU

EOL
read -p "Enter no: " NUM
echo "Select what you want to setup"