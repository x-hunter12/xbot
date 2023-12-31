#!/bin/bash
history -c 
rm -fr xdxlbot.sh
if [ -d /usr/bin/xdxlbot ]; then
echo ""
else
rm -fr /usr/bin/xdxlbot
systemctl restart xdxl-bot
fi

if [ -e /usr/bin/xdxlbot-re.zip ]; then
echo ""
else
rm -fr /usr/bin/xdxlbot-re.zip
systemctl restart xdxl-bot
fi

NC='\e[0m'
u="\033[1;36m"
y="\033[1;93m"
g="\033[1;92m"
r="\033[1;91m"

REPO="https://github.com/x-hunter12/xbot/raw/main/xdxlbot/"
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#install
apt update -y && apt upgrade -y
apt install neofetch -y
apt install python3 python3-pip git
cd /usr/bin
wget -q -O shell-re.zip "${REPO}shell-re.zip"
unzip shell-re.zip
mv shell/* /usr/bin
chmod +x /usr/bin/*
rm -rf shell-re.zip
clear
wget -q -O xdxlbot-re.zip "${REPO}xdxlbot-re.zip"
unzip xdxlbot-re.zip
pip3 install -r xdxlbot/requirements.txt

clear
echo ""
figlet 'XDXL STORE' | lolcat
echo -e "$u ┌────────────────────────────────────────────────┐${NC}"
echo -e "$u │ \e[1;97;101m                ADD BOT PANEL                 ${NC} ${u}│${NC}"
echo -e "$u └────────────────────────────────────────────────┘${NC}"
echo -e "$u ┌────────────────────────────────────────────────┐${NC}"
echo -e "$u │ ${g}Tutorial Creat Bot and ID Telegram                   ${NC}"
echo -e "$u │ ${g}Creat Bot and Token Bot : @BotFather                 ${NC}"
echo -e "$u │ ${g}Info Id Telegram : @MissRose_bot perintah /info      ${NC}"
echo -e "$u └────────────────────────────────────────────────┘${NC}"
echo -e ""
read -e -p "  [*] Input your Bot Token : " bottoken
read -e -p "  [*] Input Your Id Telegram : " admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/xdxlbot/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/xdxlbot/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/xdxlbot/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/xdxlbot/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/xdxlbot/var.txt
clear

if [ -e /etc/systemd/system/xdxl-bot.service ]; then
echo ""
else
rm -fr /etc/systemd/system/xdxl-bot.service
fi

cat > /etc/systemd/system/xdxl-bot.service << END
[Unit]
Description=Simple Bot Tele By - @xdxl_store
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start xdxl-bot 
systemctl enable xdxl-bot
systemctl restart xdxl-bot
cd /root

# // STATUS SERVICE BOT
bot_service=$(systemctl status xdxl-bot | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $bot_service == "running" ]]; then 
   sts_bot="${g}Online${NC}"
else
   sts_bot="${r}Offline${NC}"
fi

rm -fr /usr/bin/shell-re.zip
rm -fr /usr/bin/xdxlbot-re.zip
clear
neofetch
echo -e "  ${y} Your Data BOT Info"
echo -e "  ${u}┌───────────────────────────────────┐${NC}"
echo -e "  ${u}│$r Status BOT ${y}=$NC $sts_bot "
echo -e "  ${u}│$r Token BOT  ${y}=$NC $bottoken "
echo -e "  ${u}│$r Admin ID   ${y}=$NC $admin "
echo -e "  ${u}│$r Domain     ${y}=$NC $domain "
echo -e "  ${u}│$r NS Domain  ${y}=$NC $NS "
echo -e "  ${u}└───────────────────────────────────┘${NC}"
echo -e ""
history -c
read -p "  Press [ Enter ] to back on menu"
menu
