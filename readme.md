Hi, this is a guide how to run your Gensyn RL-SWARM on CPU Device or CPU based VPS, in this guide i'll add some tutorial if you use a low specs VPS. But i recommend you run with device specs recommended by Gensyn or atleast get a 16gb RAM and 4vCPU VPS you can get it from Contabo, Digital Oceans, Netcup, etc
For example i run it with Netcup VPS Specs 8vCPU and 32GB RAM, i can do RL-SWARM and CODEASSIST in the same device no problems and i will add the tutorial too in this guide

## RL-SWARM

## Swap File if you use VPS with this specs -> 4vCPU/8GB RAM with atleast 100GB Storage because SWAPFILE taking your storage to help your Device Memory (If you already use High Specs VPS SKIP THIS) 
  
  Make file Swapfile :
```
sudo fallocate -l 32G /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1G count=32 status=progress
```

  Set Perm : 
```
sudo chmod 600 /swapfile
```

  Format :
```
sudo mkswap /swapfile
```

  Enable : 
```
sudo swapon /swapfile
```

  Enable on boot : 
```
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

  Checking whether the swapfile is implemented :
```
free
```

  Reboot (if reboot makes you anxious you can skip it, but do it at your own risk) :
```
sudo reboot
```

---

## 1) Install Dependencies 

# Set up Docker's apt repository.
   Add Docker's official GPG key:
```
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

# Add the repository to Apt sources:
```
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
```
```
sudo apt update
```

# Install Docker :
```
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## If you want to run CODEASSIST too install this :
  ```
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```

## Install RL-SWARM :  
```
git clone https://github.com/gensyn-ai/rl-swarm
```

## Run RL-SWARM
```
docker compose run --rm --build -Pit swarm-cpu
```
