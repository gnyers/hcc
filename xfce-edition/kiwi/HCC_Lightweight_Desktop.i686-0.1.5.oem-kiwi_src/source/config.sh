#!/bin/bash
#================
# FILE          : config.sh
#----------------
# PROJECT       : OpenSuSE KIWI Image System
# COPYRIGHT     : (c) 2006 SUSE LINUX Products GmbH. All rights reserved
#               :
# AUTHOR        : Marcus Schaefer <ms@suse.de>
#               :
# BELONGS TO    : Operating System images
#               :
# DESCRIPTION   : configuration script for SUSE based
#               : operating systems
#               :
#               :
# STATUS        : BETA
#----------------
#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$name]..."

#======================================
# SuSEconfig
#--------------------------------------
echo "** Running suseConfig..."
suseConfig

echo "** Running ldconfig..."
/sbin/ldconfig

#======================================
# Setup default runlevel
#--------------------------------------
baseSetRunlevel 5

#======================================
# Add missing gpg keys to rpm
#--------------------------------------
suseImportBuildKey


#======================================
# Firewall Configuration
#--------------------------------------
echo '** Configuring firewall...'
chkconfig SuSEfirewall2_init on
chkconfig SuSEfirewall2_setup on

sed --in-place -e 's/# solver.onlyRequires.*/solver.onlyRequires = true/' /etc/zypp/zypp.conf

# Enable sshd
chkconfig sshd on

#======================================
# Sysconfig Update
#--------------------------------------
echo '** Update sysconfig entries...'
baseUpdateSysConfig /etc/sysconfig/keyboard KEYTABLE us.map.gz
baseUpdateSysConfig /etc/sysconfig/network/config FIREWALL yes
baseUpdateSysConfig /etc/init.d/suse_studio_firstboot NETWORKMANAGER yes
baseUpdateSysConfig /etc/sysconfig/SuSEfirewall2 FW_SERVICES_EXT_TCP 22
baseUpdateSysConfig /etc/sysconfig/console CONSOLE_FONT lat9w-16.psfu
baseUpdateSysConfig /etc/sysconfig/displaymanager DISPLAYMANAGER xdm
baseUpdateSysConfig /etc/sysconfig/windowmanager DEFAULT_WM icewm-session


#======================================
# Setting up overlay files 
#--------------------------------------
echo '** Setting up overlay files...'
xargs -L 256 chown nobody:nobody < /image/archive-manifest-4XjsL7ae.txt
mkdir -p /home/
mv /studio/overlay-tmp/files//home//firefox-add-ons.zip /home//firefox-add-ons.zip
chown nobody:nobody /home//firefox-add-ons.zip
chmod 644 /home//firefox-add-ons.zip
echo mkdir -p /
mkdir -p /
echo tar xfp /image/efc6b7dbee121c968dfc25afc64a2a9b -C /
tar xfp /image/efc6b7dbee121c968dfc25afc64a2a9b -C /
echo rm /image/efc6b7dbee121c968dfc25afc64a2a9b
rm /image/efc6b7dbee121c968dfc25afc64a2a9b
mkdir -p /
mv /studio/overlay-tmp/files///SUSEgreeter-hcc.tar.gz //SUSEgreeter-hcc.tar.gz
chown nobody:nobody //SUSEgreeter-hcc.tar.gz
chmod 644 //SUSEgreeter-hcc.tar.gz
chown root:root /studio/build-custom
chmod 755 /studio/build-custom
# run custom build_script after build
/studio/build-custom
chown root:root /studio/suse-studio-custom
chmod 755 /studio/suse-studio-custom
test -d /studio || mkdir /studio
cp /image/.profile /studio/profile
cp /image/config.xml /studio/config.xml
rm -rf /studio/overlay-tmp
true

#======================================
# SSL Certificates Configuration
#--------------------------------------
echo '** Rehashing SSL Certificates...'
c_rehash


sh /studio/configure_xdm_theme.sh

