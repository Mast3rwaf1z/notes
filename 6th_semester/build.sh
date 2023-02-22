for file in $(ls main/*)
do
    pdflatex --output-directory=log $file
done

cp log/*.pdf out