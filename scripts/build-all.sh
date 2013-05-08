#!/bin/bash

echo Building Hunspell files
echo ca.dic
./build-dic.pl > ../output/ca.dic
echo ca.aff
./build-aff.pl > ../output/ca.aff
echo 

echo Unmunching dictionary
../hunspell/src/tools/unmunch ../output/ca.dic ../output/ca.aff | sort | uniq > ../output/wordlist.output
echo


echo Analyzing word list
 ../hunspell/src/tools/analyze ../output/ca.aff ../output/ca.dic ../output/wordlist.output > ../output/wordlist.analyzed
echo


echo Generating Languagetool dictionary format
cat ../output/wordlist.analyzed | grep "^analyze(.*) =  st:" | sed -e "s/^analyze(//" -e "s/) =  st:/ /" -e "s/ po:/ /" -e "s/ is://"| sort | uniq  > ../output/wordlist.languagetool
echo

echo Finished
