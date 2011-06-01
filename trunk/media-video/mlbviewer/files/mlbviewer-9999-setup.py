#!/usr/bin/env python
# coding=utf-8
import sys
import os
import shutil
from distutils.core import setup

installMode = False
uninstallMode = False

log = "mlbviewer-install.log"
basedir = "mlbviewer"
name = "mlbviewer"

for arg in sys.argv:
	if arg == 'install':
		installMode = True
	elif arg == 'uninstall':
		uninstallMode = True

if uninstallMode:
	logfile = open(log, "r")
	maindir = ""

	# read through the install log deleting every file installed
	for filename in logfile.readlines():
		tempfile = filename.replace("\n", "") 
		print(("removing %s" % (tempfile)))
		os.remove(tempfile)

		# If the directory name ends with basedir then this is the base directory for the installation
		if os.path.dirname(tempfile).endswith(basedir):
			maindir = os.path.dirname(tempfile)

	logfile.close()

	# Remove the base installation directory
	print(("removing %s" % (maindir)))
	shutil.rmtree(maindir)
	os.remove(log)
else:
	# If called with install capture the installation to to pylotro-install.log
	if installMode:
		sys.argv = sys.argv + ['--record', log ]
		
		setup(name = 'mlbviewer' ,
		description = "Major League Baseball viewer",
		     scripts = [ "mlbviewer.py","mlbplay.py","mlblistings.py"],
		      data_files = [('share/apps/mlbviewer', 
				     ['INSTALL',
		      'LICENSE.txt',
		      'NEW-MLBPLAY',
		      'README',
		      'REQUIREMENTS-2011.txt'])],
		      
		      packages = [ 'MLBviewer', 'test' ],
		      
	      package_dir = { '': '.' }
	)

