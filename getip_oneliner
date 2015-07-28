printf "\n\nalias getip=getipfunc\n\n" >> ~/.bashrc; printf "getipfunc() {\nifconfig \$1 | awk \'/inet addr/{print substr(\$2,6)}\' | tr -d \"\\\n\"\n}\n" >> ~/.bashrc;source ~/.bashrc
