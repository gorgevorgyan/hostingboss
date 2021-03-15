# **Serve Flask Applications with Gunicorn**


## Introduction:
	This is a tool which allows you to serv your flask appliaction on linux server

## Installation

### Step 1:Installing python3

```
$ sudo apt install python3-pip
```

### Step 2:Installing git

```
$ sudo apt install git-all
``` 
### Step 3:Downloading tool

```
$ git clone https://github.com/gorgevorgyan/hostingboss
```

## Usage:
You shoud have your application uploaded in git repository
Your project folder must include 'requipments.txt' also

#### First you need to edit config.json

```
{
	"project_name":"Your project name",
	"flask_name":"Your project's flask name",
	"start_file_name":"executable file name",//EXAMPLE:if you run your project with "app.py" you should write "app"
	"Port":"Your application running port",
	"git_link":"Link of you projet's git",
	"reponame":"Repository name in which is your application",
}
```
#### Give permission to work

```
$ ./chmod +x start.sh
```

#### Than just run the sh file

```
$ ./start.sh
```
