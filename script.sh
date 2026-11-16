rm -rf Testcase*Diff

for i in {1..4}; do 

    testdirectory="Testcase$i"
    outputdir="Testcase${i}Diff"

    for j in {1..200}; do
        fileA="$testdirectory/Version${j}.1.txt"
        fileB="$testdirectory/Version${j}.2.txt"

        [ -f "$fileA" ] || continue

        if ! cmp -s "$fileA" "$fileB"; then

           mkdir -p "$outputdir"
           diff -u "$fileA" "$fileB" > "$outputdir/Version${j}Diff.txt"

        fi

    done

done