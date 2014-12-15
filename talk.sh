_PS1="$PS1"

step-tpl() {
    export PS1="Step $1 $_PS1"
    git checkout "step-$1" 2>/dev/null
    echo "===================="
    echo "$2"
    echo "===================="
    echo "Files changed:"
    git show --name-only --oneline | tail -n+2
}

lines=$(git log --oneline  --reverse | grep '\d: ' | while read line; do
    IFS=' ' read -a array <<< "$line"

    sha="${array[0]}"
    stepnum="${array[1]%%:}"

    array=("${array[@]:1}")
    array=("${array[@]:1}")

    msg=$(IFS=" " echo "$*")

    git tag -f "step-$stepnum" "$sha" 1>&2
    echo "Tagged $stepnum" >&2

    echo "step$stepnum() { step-tpl $stepnum '${array[@]//\'/\\\'}'; };"
done)

eval $lines
