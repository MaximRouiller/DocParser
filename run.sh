#!/bin/sh 

if test -d /data/$4-docs; then
    # Go to /data/docs directory and update the repository to stay up to date. Assume bare repository
    cd /data/$4-docs && git fetch origin +refs/heads/*:refs/heads/* --prune
else
    # Clone bare repository (we don't need the files). Go to /data/docs directory.
    git clone $2 /data/$4-docs --bare && cd /data/$4-docs
fi

# Generate the file with the new files added to the repository.
git log --diff-filter=A --name-only --since=$1 --pretty=''  *.md > /data/$1.NewFiles.md

nf_input="/data/$1.NewFiles.md"
nf_output="/data/$1.NewFiles.md.tmp"

touch $nf_output
sort $nf_input -o $nf_input

while read -r line
do
title=$(git show master:$line | sed -n 's/title: //p' )
title="${title//[\"]}"
echo "* ✨ [$title]($3${line}?wt.mc_id=)" >> $nf_output

done < "$nf_input"
mv $nf_output $nf_input -f

sed 's/\.md//' $nf_input > $nf_output
mv $nf_output $nf_input -f
sed 's/\/'"$6"'\//\//' $nf_input > $nf_output
mv $nf_output $nf_input -f

echo "## New Pages" > $nf_output
echo '' >> $nf_output
cat $nf_input >> $nf_output
echo '' >> $nf_output

mv $nf_output $nf_input -f


mf_input="/data/$1.ModifiedFiles.md"
mf_output="/data/$1.ModifiedFiles.md.tmp"
rm $mf_input -f
rm $mf_output -f

# Generate an extensive logs of all modified files with their added/removed lines.
git log --diff-filter=M --numstat --since=$1 --pretty=''  *.md > $mf_input

sort -t \t -k 2 $mf_input -o $mf_input


touch $mf_output
while IFS=$'\t' read -r added removed filepath
do
totalLinesAdded=$(( $added - $removed ))

if [[ $totalLinesAdded -ge $5 ]]; then
title=$(git show master:$filepath | sed -n 's/title: //p' )
title="${title//[\"]}"
echo "* [$title]($3${filepath}?wt.mc_id=)" >> $mf_output
fi

done < "$mf_input"

mv $mf_output $mf_input -f

sed 's/\.md//' $mf_input > $mf_output
mv $mf_output $mf_input -f
sed 's/\/'"$6"'\//\//' $mf_input > $mf_output
mv $mf_output $mf_input -f

echo "## Modified Pages (>=$5 total added lines)" > $mf_output
echo '' >> $mf_output
cat $mf_input >> $mf_output
mv $mf_output $mf_input -f

# Merge new files and modified files report together

echo "# $1" > /data/$4.$1.md
echo "" >> /data/$4.$1.md
echo "This is a summary of all the new and modified pages in the documentation since $1." >> /data/$4.$1.md
echo "" >> /data/$4.$1.md

cat $nf_input $mf_input >> /data/$4.$1.md

rm $mf_output $mf_input $nf_input $nf_output -f
