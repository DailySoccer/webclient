#!/bin/sh

mode="release"

if [[ $1 != "" ]]
    then
        mode=$1
fi

if [[ $mode=="release" ]]
    then
    # Aplicamos cambios de release
    client_branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    client_branch_name="(unnamed branch)"     # detached HEAD
    client_branch_name=${branch_name##refs/heads/}

    git fetch
    git checkout release
    git rebase $client_branch_name
    git push -f origin release
fi

./compile_less.sh

# mode puede ser debug|relesae
pub build --mode=$mode
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/

if [[ $mode=="release" ]]
    then
        # Volvemos a la rama original
        git checkout $client_branch_name
fi

git checkout -- .
