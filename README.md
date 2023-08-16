# Kernel Diary
This will contain daily experiences with the kernel

## Commands
Daily used COMMANDS will be placed

Adding & Removing git remote to a local repository\
`git remote -v` shows the remote repositories added\
`git remote rm origin` removes the origin remote url\
`git remote add origin <repository url>` adds new repository url

## Bash Command

`$_` will give the previous command last argument

## dmidecode - DMI(Desktop Management Interface)

This command provides us the information of all the hardware we
have. What's the memory type, processor, PCIE, etc. in human 
readable form.

`sudo dmidecode -t 17`	gives the memory information 
`sudo dmidecode -t 0` gives BIOS info
