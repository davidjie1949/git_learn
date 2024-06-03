# Create a new Linux User Account

## 1. sudo apt install openssh-server
## 2. sudo adduser cluster_01 password xxxxxxx
## 3. chmod 700 /home/cluster_01
## 4. chown cluster_01:cluster_01 /home/cluster_01
## 5. ls -ld /home/cluster_01
## 6. grep cluster_01 /etc/passwd (getent passwd cluster_01)
## 7. groups cluster_01
## 8. sudo usermod -aG sudo cluster_01(or $USEDR) (group cluster_01, cluster_01:cluster_01 .sudo)