set -f input "$PWD/$argv[1]"

if not test -d $input
    echo "input is not a directory"
else
    exiftool -if '$CreateDate' -p '$FileName' "$input" | xargs -I {} jhead -n%Y-%m-%d-%H%M%S "$input/{}"
end
