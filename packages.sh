#!/bin/bash
if [ -e /usr/bin/wget ]; then                                                       # Test if wget is installed
  echo "wget already exists" | logger                                               #
  exit 0;                                                                           # Exit if wget is installed
fi                                                                                  #
yum install -y wget                                                                 # Install wget
wget https://raw.githubusercontent.com/reason2/hello-world2/master/packages.txt     # wget the packages.txt file from github
for packages in $(cat packages.txt); do                                             # Install all packages in the packages.txt file
  yum install -y $packages                                                          #
done                                                                                #
cd /root                                                                            # cd to the home of root
git clone https://github.com/reason2/hello-world2.git                               # Clone repository from github
cd /root/hello-world2                                                               # cd to the new directory hello-world2
git config --global user.name "reason2"                                             # Set the username to reason2
git config --global user.email richard.eason@seattlecolleges.edu                    # Set the email for school email
