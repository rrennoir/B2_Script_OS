exit=0
log=/var/log
if [ -z $1 ]
then
    ls -R $log
else
    while getopts :al: option
    do
        case $option in
            a) echo option a
                for i in $(ls -R $log)
                do
                    if [ -f $log/$i ]
                    then
                        echo
                        echo log de $i
                        echo
                        cat $log/$i
                    fi
                done ;;

            l) echo option l 
                if [ -e /var/log/$OPTARG ]
                then
                    echo log de $OPTARG
                    cat /var/log/$OPTARG
                else
                    echo fichier inconnu
                fi ;;

            *) echo invalid option
                exit=1 ;;
        esac
    done
fi

exit $exit