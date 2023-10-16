#!/bin/ash

cp /usr/share/zoneinfo/${TZ} /etc/localtime
echo "${TZ}" > /etc/timezone

cd /workspace

[ -f "hostfiles.tar" ] && tar xpf hostfiles.tar -C /etc/ssh && chmod 600 /etc/ssh/ssh_host_*_key
[ -f "authorized_keys" ] && mkdir ~root/.ssh && chmod 700 ~root/.ssh && cp authorized_keys ~root/.ssh && chmod 600 ~root/.ssh/authorized_keys
[ -f "boot.sh" ] && /bin/ash ./boot.sh

tmux new-session -d -n vlmcsd 
tmux send-key -t vlmcsd "vlmcsd -v -e -D" Enter

cd /
ssh-keygen -A
/usr/sbin/sshd -D
