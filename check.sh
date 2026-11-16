#!/bin/bash
allpassed=1

for i in {1..4}; do
    testdirectory="Testcase$i"
    outputdir="Testcase${i}Diff"
    passed=1
    anydiff=0                                

    for j in {1..200}; do
        fileA="$testdirectory/Version${j}.1.txt"
        fileB="$testdirectory/Version${j}.2.txt"
        diff_file="$outputdir/Version${j}Diff.txt"

        [ -f "$fileA" ] || continue

        if cmp -s "$fileA" "$fileB"; then
            if [ -f "$diff_file" ]; then
                passed=0
            fi
        else
            anydiff=1                        
            if [ ! -f "$diff_file" ]; then
                passed=0
            else
                expected=$(diff -u "$fileA" "$fileB" | tail -n +3)
                actual=$(tail -n +3 "$diff_file")
                if [ "$expected" != "$actual" ]; then
                    passed=0
                fi
            fi
        fi
    done

    if [ "$anydiff" -eq 0 ] && [ -d "$outputdir" ]; then
        passed=0
    fi

    if [ "$passed" -eq 1 ]; then
        echo "Testcase$i: PASS"
    else
        echo "Testcase$i: FAIL"
        allpassed=0
    fi
done

if [ "$allpassed" -eq 1 ]; then
    exit 0
else
    exit 1
fi