If you already install the dependencies on RL-SWARM guide you can continue here, if you havent please visit the RL-SWARM guide first (see readme.md) and install it

## CODEASSIST

# Install CODEASSIST : 
```
git clone https://github.com/gensyn-ai/codeassist.git
cd codeassist
```

# If you want to run it in the same device you run RL-SWARM do this :
```
sed -i '0,/11434/s//11435/' compose.yml
```
```
sed -i -e 's/"11434\/tcp": 11434/"11434\/tcp": 11435/' -e 's#http://localhost:11434#http://localhost:11435#' run.py
```
```
cd web-ui/src/simulation/simulators
```
```
sed -i 's#http://localhost:11434#http://localhost:11435#' OllamaCodeSimulator.ts
```
```
cd && cd codeassist
```
```
uv run run.py --port 3001
```

# If you run from different device :
```
uv run run.py
```


# Wait for the install finished and you got the output that tells you to open http://localhost:3001 . DONT PRESS CTRL+C if you havent trained the AI
<img width="1263" height="658" alt="image" src="https://github.com/user-attachments/assets/a4e251c7-a2c0-4958-bbf4-c4ccc36c32ed" />


# If you run it on VPS on WIndows, Open Powershell in your PC/Laptop (LOCAL) and input :
```
ssh -L 3001:localhost:3001 -L 8000:localhost:8000 -L 8008:localhost:8008 root@ipvps
```
Change IPVPS with your VPS IP and login with your password and open the web http://localhost:3001 
