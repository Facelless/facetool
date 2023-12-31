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

function sqlinject() {

        echo ""
        echo -n "Pressione Enter para ir a tela home do sql injection..."
        read -n 1 key

        case "$key" in
        "")
                clear
                sqlmap
                ;;
        *)
                echo "Você pressionou uma tecla diferente."
                ;;
        esac
}

function sqlmap() {
        clear
        echo -e ' \033[01;31m 
         ____     ___    _         ___             _                 _     _                 
        / ___|   / _ \  | |       |_ _|  _ __     (_)   ___    ___  | |_  (_)   ___    _ __  
        \___ \  | | | | | |        | |  | "_ \    | |  / _ \  / __| | __| | |  / _ \  | "_ \ 
         ___) | | |_| | | |___     | |  | | | |   | | |  __/ | (__  | |_  | | | (_) | | | | |
        |____/   \__\_\ |_____|   |___| |_| |_|  _/ |  \___|  \___|  \__| |_|  \___/  |_| |_|\033[01;37m'
        echo ''
        echo -e '
        \033[01;31m[URLS]\033[01;37m                                    \033[01;31m[AQRUIVOS]\033[01;37m

        \033[01;31m[1]\033[01;37m Searching DB                       \033[01;31m[5]\033[01;37m Searhing DB of archive                     \033[01;31m[9]\033[01;37m Exit
        \033[01;31m[2]\033[01;37m Query DB                           \033[01;31m[6]\033[01;37m Query DB of archives
        \033[01;31m[3]\033[01;37m Query Tables in DB                 \033[01;31m[7]\033[01;37m Query Tables in DB of archives
        \033[01;31m[4]\033[01;37m Query Dates in Tables              \033[01;31m[8]\033[01;37m Query Dates in Tables
        '
        read -p '[root@root]=# ' n
        case $n in
                1) 
                        read -p '[url]=# ' url
                        python sqlmap.py -u -r $url --forms --crawl=2 -dbs
                        sqlinject;;
                2) 
                        read -p '[url]=# ' url
                        read -p '[database]=# ' db
                        python sqlmap.py -u $url --forms --crawl=2 -D $db --tables
                        sqlinject;;
                3)
                        read -p '[url]=# ' url
                        read -p '[database]=# ' db
                        read -p '[tables]=# ' table
                        python sqlmap.py -u $url --forms --crawl=2 -D $db -T $table --columns
                        sqlinject;;
                4)
                        read -p '[url]=# ' url
                        read -p '[database]=# ' db
                        read -p '[tables]=# ' table
                        read -p '[dates]=# ' dates
                        python sqlmap.py -u $url --forms --crawl=2 -D $db -T $table -C $dates --dump
                        sqlinject;;
                5)      
                        read -p '[filename]=# ' filename
                        python sqlmap.py -r $filename -dbs
                        sqlinject;;
                6)
                        read -p '[filename]=# ' filename
                        read -p '[database]=# ' database
                        python sqlmap.py -r $filename -D $database --tables
                        sqlinject;;
                7)
                        read -p '[filename]=# ' filename
                        read -p '[database]=# ' db
                        read -p '[tables]=# ' table
                        python sqlmap.py -r $filename -D $db -T $table --columns
                        sqlinject;;
                8)
                        read -p '[filename]=# ' filename
                        read -p '[database]=# ' db
                        read -p '[tables]=# ' table
                        read -p '[dates]=# ' dates
                        python sqlmap.py -r $filename  -D $db -T $table -C $dates --dump
                        sqlinject;;
                9)
                        sqlmap;;
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
        hydra $hostname http-form-$method "$rota:$valu=^USER^&$valp=^PASS^:login page" -L all.txt -P all.txtsh
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
        \033[01;31m[4]\033[01;37m Pagescan                   \033[01;31m[8]\033[01;37m Sql Injection
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
                                sudo systemctl disable --now tor.service
                                systemctl status tor.service
                                configHome;;
                        7) 
                                hydracommands
                                configHome;;
                        8) 
                                cd
                                cd sqlmap-dev
                                sqlmap
                esac
        done
}

Init
