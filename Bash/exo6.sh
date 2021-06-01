while read line; do
    if [ $(echo $line | cut -d: -f3) -gt 500 ]; then
        echo $line | cut -d: -f1,3,7
    fi
done </etc/passwd
