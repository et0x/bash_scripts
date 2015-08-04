echo '## Regular repositories' > /etc/apt/sources.list
echo 'deb http://http.kali.org/kali kali main non-free contrib' >> /etc/apt/sources.list
echo 'deb http://security.kali.org/kali-security kali/updates main contrib non-free' >> /etc/apt/sources.list
echo '## Source repositories' >> /etc/apt/sources.list
echo 'deb-src http://http.kali.org/kali kali main non-free contrib' >> /etc/apt/sources.list
echo 'deb-src http://security.kali.org/kali-security kali/updates main contrib non-free' >> /etc/apt/sources.list

apt-get clean
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

apt-get install flashplugin-nonfree -y
update-flashplugin-nonfree --install

apt-get install tor -y
service tor start

service postgresql start
service metasploit start
service metasploit stop
service postgresql stop

msfupdate

echo -n "Enter a non-root user to create: "
read user

while [[ -z "$user" ]]
do
	echo -n "\nEnter a non-root user to create: "
	read user
done

useradd -m $user
passwd $user
usermod -a -G sudo $user
chsh -s /bin/bash $user

echo "[+] All done! Now log out of root, and log back in as your new user!"
