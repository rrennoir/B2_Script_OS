exit=0
if ! [ -z $1 ]
then
    while getopts :abc option
    do
        case $option in
            a) echo option a ;;
            b) echo option b ;;
            c) echo option c ;;
            *) echo invalid option
            exit=1 ;;
        esac
    done
else
    echo please enter something
    exit=2
fi

exit $exit