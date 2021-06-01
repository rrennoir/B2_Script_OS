if [ $# -eq 1 ]; then
    if [ -f $1 ]; then
        echo $1 est un fichier

    elif [ -d $1 ]; then
        echo $1 est un dossier

    elif [ -x $1 ]; then
        echo $1 est un exécutable
    fi

    type=$(file $1 | cut -d: -f2)
    echo $1 est un fichier de type : $type

    exit=0
else
    echo "pas d'agrs :("
    exit=1
fi

exit $exit
