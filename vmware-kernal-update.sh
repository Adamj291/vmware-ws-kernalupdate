#! /bin/bash
version=`vmware --version | sed -s 's/VMware\ Workstation\ //g ' | sed "s/\ build-*[0-9]*//g"`

# git clone https://github.com/mkubecek/vmware-host-modules.git && cd vmware-host-modules && git checkout workstation-(version) 
# echo "Your VMware version is" "$version"

# Check to see if script is run as sudo

if [ "$EUID" -ne 0 ]
  then echo "Please re-run with sudo, or use \"sudo !!\""
  exit
fi

# Apply VMWare Script

git clone https://github.com/mkubecek/vmware-host-modules.git && # Clones the fix repository
cd vmware-host-modules && git checkout workstation-"$version" &&  # Changes into the fix directory
make && make install && /etc/init.d/vmware start && # Runs the fix and the init configuration
cd .. && rm -R ./vmware-host-modules &&  # Exits directory and removes cloned files
printf '\n%s\n' 'VMWare has now been updated to your current Kernel' && exit # Displays confirmation and script exit

$SHELL
