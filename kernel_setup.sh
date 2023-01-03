#!/bin/bash

# RESET
CO='\033[0m'

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

echo -e "${BPurple}"
read -p "Enter user.email for git: " MAIL
read -p "Enter user.name for git: " NAME
read -p "Enter comment for \"ssk-keygen -C\"" SSH_C
echo -e "${CO}"
sudo apt -y update && sudo apt -y upgrade
CORE_COUNT=egrep -c '(vmx | svm)' /proc/cpuinfo
if [ $CORE_COUNT > 0 ]
then
	echo -e "${BGreen}---** Vitualization OK **---${CO}"
else
	echo -e "${BRed}"
	echo "Enable Virtualization in BIOS --> EXITING"
	echo -e "${CO}"
	exit 0
fi

sudo apt -y install vim git openssh-client libssl-dev \
		 linux-headers-`uname -r` build-essential \
		 dwarves zstd libelf-dev flex bison exuberant-ctags \
		 cscope git-email libncurses5-dev gcc make terminator \
		 bc libz-dev openssl vim-gtk3 \

sudo apt -y install kernel-package fakeroot ccache qemu qemu-kvm qemu-system \
		 libvirt-daemon bridge-utils virt-manager gdb

echo -e "
#This is for the cd.. so that you can go to specified directory

function cd_up() {
	case \$1 in
	*[!0-9]*)
		cd \$( pwd | sed -r \"s|(.*/\$1[^/]*/).*|\1|\" )
		;;
	*)
		cd \$(printf \"%0.0s../\" \$(seq 1 \$1));
		;;
	esac
}
alias 'cd..'='cd_up'

" >> ~/.bashrc

cat <<- EOF >> ~/.vimrc
syntax on
set title
set number
set cc=80
set autoindent
colorscheme delek
set columns=80
set mouse=a
set guioptions+=k
set guioptions-=L

set splitbelow
set splitright
set equalalways
set clipboard=unnamedplus

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
EOF

git config --global user.email "$MAIL"
git config --global user.name "$NAME"
git config --global core.editor vim
ssh-keygen -t ed25519 -C "$SSH_C"

echo -e "${BCyan}"
echo
echo "Paste the following in your GitHub ssh"
echo
cat ~/.ssh/*.pub
echo
echo -e "${CO}"

sudo usermod -aG libvirt $USER 
sudo usermod -aG kvm $USER

sudo systemctl start libvirtd
sudo systemctl enable libvirtd

echo -e "${BGreen} Sucessfully DONE. ${CO} Just Restart or Logout & LogIn again"
