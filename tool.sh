function configHome() {
        echo ""
        echo -n "Pressione Enter para limpar o terminal..."
        read -n 1 key

        case "$key" in
        "")
                clear
                Init
                ;;
        *)
                echo "Você pressionou uma tecla diferente."
                ;;
        esac

}


function hydracommands() {
        read -p '[hostname]=# ' hostname
        read -p '[method (post/get)]=# ' method
        read -p '[rota]=# ' rota
        read -p '[value username]=# ' valu
        read -p '[value password]=# ' valp
        cd ../../
        cd wordlists
        hydra $hostname http-form-$method "$rota:$valu=^USER^&$valp=^PASS^:login page" -L all.txt -P all.txt
}

function Init() {
        clear
        while true; do
                echo -e ' \033[01;31m        ______                    _                  _ 
        |  ___|                   | |                | |
        | |_     __ _   ___   ___ | |_   ___    ___  | |
        |  _|   / _` | / __| / _ \| __| / _ \  / _ \ | |
        | |    | (_| || (__ |  __/| |_ | (_) || (_) || |
        \_|     \__,_| \___| \___| \__| \___/  \___/ |_|
                                                                        \033[01;37m'
                echo ''
                echo -e '
        \033[01;31m[1]\033[01;37m Portscan                   \033[01;31m[5]\033[01;37m Start Proxychain + Tor
        \033[01;31m[2]\033[01;37m Fast PortScan              \033[01;31m[6]\033[01;37m Stop Proxychain + Tor
        \033[01;31m[3]\033[01;37m Aggressive PortScan        \033[01;31m[7]\033[01;37m Hydra Commands
        \033[01;31m[4]\033[01;37m Pagescan
                '
                echo ''
                read -p '[root@root]=# ' n
                case $n in 
                        1) 
                                cd src/portscans/binaries/portscans
                                ./portscannormal
                                configHome;;
                        2) 
                                cd src/portscans/binaries/portscans
                                ./portscanfast
                                configHome;;
                        3) 
                                cd src/portscans/binaries/portscans
                                ./portscanaggressive
                                configHome;;
                        4) 
                                cd src/pagescan/binaries/pagescan
                                ./pagescan
                                configHome;;
                        5) 
                                sudo systemctl enable --now tor.service
                                systemctl status tor.service
                                configHome;;
                        6)      
                                sudo systemctl enable --now tor.service
                                systemctl status tor.service
                                configHome;;
                        7) 
                                hydracommands
                                configHome;;
                esac
        done
}

Init