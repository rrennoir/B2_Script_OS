echo "number of agrs: " $#

for var in "$@"
do
    if [ $var = "robert" ]
    then
        echo "sup roberto"
    elif [ $var = "test" ]
    then
        echo "attention ceci est un compte de test"
    elif [ $var = "root" ]
    then
        echo "Bienvenue administrateur"
    else
        echo "Erreur"
        exit 1
    fi
done
exit 0