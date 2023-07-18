 "Enter the file name"
read filename

echo "Splitting the file $filename"
split -l 9998 $filename NEW_FILE_

echo "Creating the lst file"
exec `rm NEW_FILE_sp_.lst`
exec `touch NEW_FILE_sp_.lst`

echo "Appending .txt at the end"
for line in `ls NEW_FILE_*`
do
mv $line $line.txt
#$echo $line.txt >> NEW_FILES_sp_.lst
done
