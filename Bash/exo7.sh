exit=0
if [ $# -gt 1 ]; then

    while getopts hos: option; do
        case $option in
        h)
            echo "Usage: login;pwd"
            ;;

        o)
            login=$(cat $2 | cut -d\; -f1)
            psw=$(cat $2 | cut -d\; -f2)
            epsw=$(perl -e 'print crypt($ARGV[0], "password")' $psw)
            useradd -m -p "$epsw" "$login"
            ;;

        s)
            login=$(cat $2 | cut -d$OPTARG -f1)
            psw=$(cat $2 | cut -d$OPTARG -f2)
            epsw=$(perl -e 'print crypt($ARGV[0], "password")' $psw)
            useradd -m -p "$epsw" "$login"
            ;;
        esac
    done

else
    exit=1
fi

exit $exit
