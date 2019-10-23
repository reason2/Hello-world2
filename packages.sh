#!/bin/bash
yum -y install wget
for packages in $(cat packages.txt); do 
   yum -y install $packages
done

#!/bin/bash
if [ -e /usr/bin/wget ]; then                                                       # Test if wget is installed
  echo "wget already exists" | logger                                               #
  exit 0;                                                                           # Exit if wget is installed
fi                                                                                  #
yum install -y wget                                                                 # Install wget
wget https://raw.githubusercontent.com/Hackat1/hello-world2/master/packages.txt     # wget the packages.txt file from github
for packages in $(cat packages.txt); do                                             # Install all packages in the packages.txt file
  yum install -y $packages                                                          #
done                                                                                #
cd /root                                                                            # cd to the home of root
git clone https://github.com/Hackat1/hello-world2.git                               # Clone repository from github
cd /root/hello-world2                                                               # cd to the new directory hello-world2
git config --global user.name "Hackat1"                                             # Set the username to Hackat1
git config --global user.email christopher.hackat1@seattlecolleges.edu              # Set the email
