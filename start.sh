#!/usr/bin/env python3
import os
import time
import getpass
import json
import sys
import subprocess
try:
	print('Getting Username')
	username=getpass.getuser()
except:
	print("Faild to get Username")
	sys.exit()
finally:
	print('Successed! Username is '+username)
time.sleep(2)

try:
	print('Reading config file')
	fj = open('config.json',) 
	data = json.load(fj) 
	start_file_name=data['start_file_name'] 
	flask_name=data['flask_name'] 
	project_name=data['project_name'] 
	Port=data['Port'] 
	git_link=data['git_link']
	reponame=data['reponame']
except:
	print("Failed to read config file")
	sys.exit()
finally:
	print('Successed!')
	fj.close()

project_name_env=project_name+'env'
project_service_name=project_name+'.service'
time.sleep(2)

try:
	print('Updating system')
	os.system('sudo apt update')
except:
	print('Failed to update system')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)

try:
	print('Installing tools')
	os.system('sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools git-all')
except:
	print('Failed to intall tools')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)
try:
	print('Installing python3-venv')
	os.system('sudo apt install python3-venv')
except:
	print('Failed to intall python3-venv')
	sys.exit()
finally:
	print('Successed!')

time.sleep(2)
try:
	print('Creating project folder')
	os.system('mkdir ~/'+project_name)
except:
	print('Failed to create project folder')
	sys.exit()
finally:
	print('Successed!')

time.sleep(2)
try:
	print('Changing directory')
	print(os.getcwd())
	os.chdir(str(os.getcwd())+'/'+project_name)
	print(os.getcwd())
except:
	print('Failed to change directory')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)

try:
	print('Creating environment')
	os.system('python3 -m venv '+project_name_env)
except:
	print('Failed to create environment')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)
try:
	print('Installing wheel')
	subprocess.call(['{0}/bin/pip3'.format(project_name_env), 'install', 'wheel'])
except:
	print('Failed to install wheel')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)
try:
	print('Installing gunicorn')
	subprocess.call(['{0}/bin/pip3'.format(project_name_env), 'install', 'gunicorn'])
except:
	print('Failed to install gunicorn')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)
try:
	print('Installing eventlet')
	subprocess.call(['{0}/bin/pip3'.format(project_name_env), 'install', 'eventlet'])
except:
	print('Failed to install eventlet')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)
try:
	print('Cloning project folder from git')
	os.system('git clone '+git_link)
	os.chdir(str(os.getcwd())+'/'+reponame)
except:
	print('Failed to clone project folder from git')
	sys.exit()
finally:
	print('Successed!')
try:
	print('Installing requipments')
	time.sleep(2)
	os.system('pip3 install -r requipments.txt')
except:
	print('Failed to install requipments')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)

time.sleep(2)
try:
	print('Creating service file')
	os.system('sudo chmod -R 0777 /etc/systemd/system/')
	service_file_path="/etc/systemd/system/"+project_service_name
	service_file=open(service_file_path, "w")
	service_file.write("""
	[Unit]
	Description=Gunicorn instance to serve """+project_name+"""
	After=network.target

	[Service]
	User="""+username+"""
	Group=www-data
	WorkingDirectory=/home/"""+username+"""/"""+project_name+"""/"""+reponame+"""
	Environment="PATH=/home/"""+username+"""/"""+project_name+"""/"""+project_name_env+"""/bin"
	ExecStart=/home/"""+username+"""/"""+project_name+"""/"""+project_name_env+"""/bin/gunicorn """+start_file_name+""":"""+flask_name+""" --worker-class eventlet -w 1 --bind 0.0.0.0:"""+Port+""" --reload

	[Install]
	WantedBy=multi-user.target""")
except:
	print('Failed to create serve file')
	sys.exit()
finally:
	print('Successed!')
	service_file.close()
time.sleep(2)
try:
	print('Starting project')
	os.system('sudo systemctl start '+project_name)
except:
	print('Failed to start project')
	sys.exit()
finally:
	print('Successed!')
time.sleep(2)
try:
	print('Enabling project')
	os.system('sudo systemctl enable '+project_name)
except:
	print('Failed to enable project')
	sys.exit()
finally:
	print('Successed!')
	print('Application is running on port '+Port)

