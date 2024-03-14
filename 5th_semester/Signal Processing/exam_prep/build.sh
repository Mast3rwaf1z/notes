pandoc -t latex $1 -o out.pdf
screen -dmS okular okular out.pdf
