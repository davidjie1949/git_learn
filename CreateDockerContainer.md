# Create a Docker container
Dockerfile -> Docker Img -> Docker Container -> Access the App
## 1). Step 1 - Create a new directory
$mkdir myapp
$cd myapp
## 2). Step 2 - Create a file called "index.html"
$ echo "Hello, world!" > index.html
## 3). Step 3 - Create a file named Dockerfile
$ touch Dockerfile
## 4). Step 4 - Open the "Dockerfile" file in a text editor and add the following lines:
FROM
COPY 
## 5). Step 5 - Start docker & build docker img from Dockerfile on current directory
$docker build -t myapp .
## 6). Step 6 - Run docker container from the img
$docker run -p 8080:80 myapp
$docker run -d -p 8080:80 myapp (running in the backend)
$docker ps
## 7). Step 7 - Access the app
open a web browser and navigate to http://localhost:8080 to see the "Hello, world!" message displayed in your web browser.
$sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io