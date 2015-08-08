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
	echo -n "Enter a non-root user to create: "
	read user
done

useradd -m $user
passwd $user
usermod -a -G sudo $user
chsh -s /bin/bash $user

git clone https://github.com/longld/peda.git /home/$user/peda
echo "source /home/$user/peda/peda.py" >> /home/$user/.gdbinit
chown $user:$user /home/$user/.gdbinit
chown -R $user:$user /home/$user/peda

cd ~

X=`uname -m`

if [[ $X == *"64"* ]]
then
        Y=`curl -s www.sublimetext.com/2 | grep .bz2 | grep -iv portable| grep 64 | cut -d'"' -f4`
else
        Y=`curl -s www.sublimetext.com/2 | grep .bz2 | grep -iv portable| grep 32 | cut -d'"' -f4`
fi

wget "$Y"
F=`basename "$Y"`
mv "$F" sublime.tar.bz2
tar xvf sublime.tar.bz2

echo "[+] All done! Now log out of root, and log back in as your new user!"
