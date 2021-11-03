[[ $(whoami) != root ]] && { echo "Must be run by root!"; exit -1; }

apt install x11vnc

if [[ ! -d /etc/x11vnc ]]; then
    mkdir /etc/x11vnc
fi

x11vnc --storepasswd /etc/x11vnc/vncpwd

cat <<EOF > x11vnc.service
[Unit]
Description=x11vnc service
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -noxdamage -repeat -rfbauth /etc/x11vnc/vncpwd -rfbport 5900

[Install]
WantedBy=multi-user.target
EOF

mv x11vnc.service /etc/systemd/system

systemctl daemon-reload
systemctl enable x11vnc.service
systemctl start x11vnc.service

