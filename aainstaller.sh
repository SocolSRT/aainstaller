#!/bin/sh

LOG_PIPE=log.pipe
rm -f LOG_PIPE
mkfifo ${LOG_PIPE}
LOG_FILE=log.file
rm -f LOG_FILE
tee < ${LOG_PIPE} ${LOG_FILE} &

exec  > ${LOG_PIPE}
exec  2> ${LOG_PIPE}

# AAInstaller
# Update 17.12.2022

Infon() {
	printf "\033[1;32m$@\033[0m"
}
Info()
{
	Infon "$@\n"
}
Error()
{
	printf "\033[1;31m$@\033[0m\n"
}
Error_n()
{
	Error "- - - $@"
}
Error_s()
{
	Error "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
}
log_s()
{
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
}
log_n()
{
	Info "- - - $@"
}
log_t()
{
	log_s
	Info "- - - $@"
	log_s
}
infomenu()
{
	Info "${yellow}♥ • • • • • • | ${green}Добро пожаловать в/Welcome to ${BLUE}AAInstaller ${yellow}| • • • • • • ♥"
}
log_tt()
{
	Info "• —————————————————————————— ${red}$@${green} ——————————————————————————— • "
}
log_tt1()
{
	Info "• ——————————————— ${red}$@${green} ————————————————— •"
}
RED=$(tput setaf 1)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
white=$(tput setaf 7)
reset=$(tput sgr0)
toend=$(tput hpa $(tput cols))$(tput cub 6)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
LIME_YELLOW=$(tput setaf 190)
CYAN=$(tput setaf 6)

centos_packet_nginx()
{
yum -y update && yum -y upgrade && yum -y install curl wget sudo nginx
}
centos_packet_apache()
{
yum -y update && yum -y upgrade && yum -y install curl wget sudo httpd
}
centos_packet_ols()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
wget https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh && bash ols1clk.sh
}
centos_packet_nodejs()
{
yum -y update && yum -y upgrade && yum -y install curl wget sudo nodejs npm
}
centos_packet_python3()
{
yum -y update && yum -y upgrade && yum -y install curl wget sudo python3 python3-pip
}
centos_packet_python2()
{
yum -y update && yum -y upgrade && yum -y install curl wget sudo python2 python2-pip
}
centos_packet_doker()
{
yum -y update && yum -y upgrade && yum -y install curl wget sudo docker docker-compose
}
centos_packet_iptables()
{
yum -y update && yum -y upgrade && yum -y install curl wget sudo iptables
}
centos_packet()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "- - - • ${BLUE}Web Server ${green}✔"
	Info "• - ${red}1${white}  -  Nginx"
	Info "• - ${red}2${white}  -  Apache"
	Info "• - ${red}3${white}  -  OpenLiteSpeed"
	Info "- - - • ${BLUE}Other ${green}✔"
	Info "• - ${red}4${white}  -  NodeJS"
	Info "• - ${red}5${white}  -  Python3"
	Info "• - ${red}6${white}  -  Python2"
	Info "• - ${red}7${white}  -  Doker"
	Info "• - ${red}8${white}  -  IPtables"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) centos_packet_nginx;;
		2) centos_packet_apache;;
		3) centos_packet_ols;;
		4) centos_packet_nodejs;;
		5) centos_packet_python3;;
		6) centos_packet_python2;;
		7) centos_packet_doker;;
		8) centos_packet_iptables;;
		9) centos_menu;;
		0) exit;;
	esac
}
centos_software_vddos()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
wget https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/latest.sh ; chmod 700 latest.sh ; bash latest.sh
}
centos_software_csf()
{
yum -y install libwww-perl unzip
cd /usr/src/
wget 'https://download.configserver.com/csf.tgz'
tar -xvf csf.tgz
cd csf
sh install.sh
chkconfig --levels 235 csf on
chkconfig --levels 235 lfd on
cd /etc/csf/
sed -i 's/TESTING = "1"/TESTING = "0"/g' /etc/csf/csf.conf
sed -i 's/RESTRICT_SYSLOG = "0"/RESTRICT_SYSLOG = "3"/g' /etc/csf/csf.conf
csf -r && csf -q && service lfd restart
service csf start
service lfd start
cd
}
centos_software_crowdsec()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.rpm.sh | sudo bash
yum install crowdsec
yum install crowdsec-firewall-bouncer-iptables
}
centos_software()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "- - - • ${BLUE}Firewall ${green}✔"
	Info "• - ${red}1${white}  -  Crowdsec"
	Info "• - ${red}2${white}  -  CSF Firewall"
	Info "- - - • ${BLUE}Reverse Proxy ${green}✔"
	Info "• - ${red}3${white}  -  vDDoS Protection"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) centos_software_crowdsec;;
		2) centos_software_csf;;
		3) centos_software_vddos;;
		9) centos_menu;;
		0) exit;;
	esac
}
centos_cp_game_gameap()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
curl -sLO http://packages.gameap.ru/installer.sh && bash installer.sh
}
centos_cp_game()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  GameAP"
	Info "• - ${red}*${white}  -  Pterodactyl (В разработке/in developing)"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) centos_cp_game_gameap;;
		9) centos_cp;;
		0) exit;;
	esac
}
centos_cp_web_aapanel()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh aapanel
}
centos_cp_web_cwp8()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum -y update
cd /usr/local/src
wget http://centos-webpanel.com/cwp-el8-latest
sh cwp-el8-latest
echo 'Control WebPanel Admin GUI at http://SERVER-IP:2030/
Username: root
Password: YOUR_ROOT_PASSWORD'
}
centos_cp_web_cwp7()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum -y update
cd /usr/local/src
wget http://centos-webpanel.com/cwp-el7-latest
sh cwp-el7-latest
echo 'Control WebPanel Admin GUI at http://SERVER-IP:2030/
Username: root
Password: YOUR_ROOT_PASSWORD'
}
centos_cp_web_brainycp()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
wget -O install.sh http://core.brainycp.com/install.sh && bash ./install.sh
}
centos_cp_web_cyberpanel()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
wget https://cyberpanel.net/install.sh && bash install.sh
}
centos_cp_web_vestacp()
{
yum -y update && yum -y upgrade
yum -y install curl wget sudo
curl -O http://vestacp.com/pub/vst-install.sh && bash vst-install.sh
}
centos_cp_web()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  VestaCP"
	Info "• - ${red}2${white}  -  CyberPanel"
	Info "• - ${red}3${white}  -  BrainyCP"
	Info "• - ${red}4${white}  -  COS Web Panel (CentOS 7)"
	Info "• - ${red}5${white}  -  COS Web Panel (AlmaLinux)"
	Info "• - ${red}6${white}  -  aaPanel"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) centos_cp_web_vestacp;;
		2) centos_cp_web_cyberpanel;;
		3) centos_cp_web_brainycp;;
		4) centos_cp_web_cwp7;;
		5) centos_cp_web_cwp8;;
		6) centos_cp_web_aapanel;;
		9) centos_cp;;
		0) exit;;
	esac
}
centos_cp()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  Web Panel"
	Info "• - ${red}2${white}  -  Game Panel"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) centos_cp_web;;
		2) centos_cp_game;;
		9) centos_menu;;
		0) exit;;
	esac
}
centos_menu()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  Control Panel"
	Info "• - ${red}2${white}  -  SoftWare"
	Info "• - ${red}3${white}  -  Packet"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) centos_cp;;
		2) centos_software;;
		3) centos_packet;;
		9) menu;;
		0) exit;;
	esac
}

ubuntu_packet_nginx()
{
apt -y update && apt -y upgrade && apt -y install curl wget sudo nginx
}
ubuntu_packet_apache()
{
apt -y update && apt -y upgrade && apt -y install curl wget sudo apache2
}
ubuntu_packet_ols()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh && bash ols1clk.sh
}
ubuntu_packet_nodejs()
{
apt -y update && apt -y upgrade && apt -y install curl wget sudo nodejs npm
}
ubuntu_packet_python3()
{
apt -y update && apt -y upgrade && apt -y install curl wget sudo python3 python3-pip
}
ubuntu_packet_python2()
{
apt -y update && apt -y upgrade && apt -y install curl wget sudo python2 python2-pip
}
ubuntu_packet_doker()
{
apt -y update && apt -y upgrade && apt -y install curl wget sudo docker docker-compose
}
ubuntu_packet_iptables()
{
apt -y update && apt -y upgrade && apt -y install curl wget sudo iptables
}
ubuntu_packet()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "- - - • ${BLUE}Web Server ${green}✔"
	Info "• - ${red}1${white}  -  Nginx"
	Info "• - ${red}2${white}  -  Apache"
	Info "• - ${red}3${white}  -  OpenLiteSpeed"
	Info "- - - • ${BLUE}Other ${green}✔"
	Info "• - ${red}4${white}  -  NodeJS"
	Info "• - ${red}5${white}  -  Python3"
	Info "• - ${red}6${white}  -  Python2"
	Info "• - ${red}7${white}  -  Doker"
	Info "• - ${red}8${white}  -  IPtables"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) ubuntu_packet_nginx;;
		2) ubuntu_packet_apache;;
		3) ubuntu_packet_ols;;
		4) ubuntu_packet_nodejs;;
		5) ubuntu_packet_python3;;
		6) ubuntu_packet_python2;;
		7) ubuntu_packet_doker;;
		8) ubuntu_packet_iptables;;
		9) ubuntu_menu;;
		0) exit;;
	esac
}
ubuntu_software_vddos()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/latest.sh ; chmod 700 latest.sh ; bash latest.sh
}
ubuntu_software_npm()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo docker docker-compose
echo 'version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt' > docker-compose.yml
docker-compose up -d
}
ubuntu_software_tcpguard()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget https://download.safeness.su/firewall-safeness.sh
chmod +x firewall-safeness.sh 
sh firewall-safeness.sh 
}
ubuntu_software_csf()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
sudo apt remove ufw
sudo apt install perl zip unzip libwww-perl liblwp-protocol-https-perl
sudo apt install sendmail-bin
cd /usr/src
sudo wget https://download.configserver.com/csf.tgz
sudo tar -xzvf csf.tgz
cd csf
sudo sh install.sh
sudo perl /usr/local/csf/bin/csftest.pl
sed -i 's/TESTING = "1"/TESTING = "0"/g' /etc/csf/csf.conf
sed -i 's/RESTRICT_SYSLOG = "0"/RESTRICT_SYSLOG = "3"/g' /etc/csf/csf.conf
csf -ra
cd
}
ubuntu_software_crowdsec()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
apt install crowdsec
apt install crowdsec-firewall-bouncer-iptables
}
ubuntu_software()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "- - - • ${BLUE}Firewall ${green}✔"
	Info "• - ${red}1${white}  -  Crowdsec"
	Info "• - ${red}2${white}  -  CSF Firewall"
	Info "• - ${red}3${white}  -  TCPGuard.ru"
	Info "- - - • ${BLUE}Reverse Proxy ${green}✔"
	Info "• - ${red}4${white}  -  Nginx Proxy Manager"
	Info "• - ${red}5${white}  -  vDDoS Protection"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) ubuntu_software_crowdsec;;
		2) ubuntu_software_csf;;
		3) ubuntu_software_tcpguard;;
		4) ubuntu_software_npm;;
		5) ubuntu_software_vddos;;
		9) ubuntu_menu;;
		0) exit;;
	esac
}
ubuntu_cp_game_gameap()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
curl -sLO http://packages.gameap.ru/installer.sh && bash installer.sh
}
ubuntu_cp_game()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  GameAP"
	Info "• - ${red}*${white}  -  Pterodactyl (В разработке/in developing)"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) ubuntu_cp_game_gameap;;
		9) ubuntu_cp;;
		0) exit;;
	esac
}
ubuntu_cp_web_hestia()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh && bash hst-install.sh
}
ubuntu_cp_web_aapanel()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
}
ubuntu_cp_web_ispconfig()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget -O - https://get.ispconfig.org | sh -s -- --help
}
ubuntu_cp_web_brainycp()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget -O install.sh http://core.brainycp.com/install.sh && bash ./install.sh
}
ubuntu_cp_web_cyberpanel()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
wget https://cyberpanel.net/install.sh && bash install.sh
}
ubuntu_cp_web_vestacp()
{
apt -y update && apt -y upgrade
apt -y install curl wget sudo
curl -O http://vestacp.com/pub/vst-install.sh && bash vst-install.sh
}
ubuntu_cp_web()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  VestaCP"
	Info "• - ${red}2${white}  -  CyberPanel"
	Info "• - ${red}3${white}  -  BrainyCP"
	Info "• - ${red}4${white}  -  ISPconfig"
	Info "• - ${red}5${white}  -  aaPanel"
	Info "• - ${red}6${white}  -  Hestia"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) ubuntu_cp_web_vestacp;;
		2) ubuntu_cp_web_cyberpanel;;
		3) ubuntu_cp_web_brainycp;;
		4) ubuntu_cp_web_ispconfig;;
		5) ubuntu_cp_web_aapanel;;
		6) ubuntu_cp_web_hestia;;
		9) ubuntu_cp;;
		0) exit;;
	esac
}
ubuntu_cp()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  Web Panel"
	Info "• - ${red}2${white}  -  Game Panel"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) ubuntu_cp_web;;
		2) ubuntu_cp_game;;
		9) ubuntu_menu;;
		0) exit;;
	esac
}
ubuntu_menu()
{
	clear
	Info
	Info "- - - • Выберите, что вы хотите установить${white}/${BLUE}Choose what you want to install ${green}✔"
	Info "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	Info "• - ${red}1${white}  -  Control Panel"
	Info "• - ${red}2${white}  -  SoftWare"
	Info "• - ${red}3${white}  -  Packet"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}9${white}  -  Назад/Back"
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) ubuntu_cp;;
		2) ubuntu_software;;
		3) ubuntu_packet;;
		9) menu;;
		0) exit;;
	esac
}
menu()
{
	clear
	Info
	log_t "• Добро пожаловать в${white}/${BLUE}Welcome to ${YELLOW} AAInstaller ${green}✔"
	Info "- - - • Выберите${white}/${BLUE}Select ${YELLOW} OS ${green}✔"
	Info "• - ${red}1${white}  -  Ubuntu / Debian"
	Info "• - ${red}2${white}  -  CentOS / AlmaLinux"
	Info "- - - - - - - - - - - - - - - - - - - "
	Info "• - ${red}0${white}  -  Выход/Exit"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню/Please enter a menu item: " case
	case $case in
	    1) ubuntu_menu;;
		2) centos_menu;;
		0) exit;;
	esac
}
menu