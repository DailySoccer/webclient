#!/bin/sh

mode="release"

if [[ $1 != "" ]]
    then
        mode=$1
fi

if [[ "$mode" == "release" ]]
    then
    # Aplicamos cambios de release
    sed -i".bak" '/<!--/{ N; N; s/.*\n\(.*main.dart.js.*\)\n.*-->.*/\1/; }' web/index.html
    sed -i".bak" '/src="main.dart"/d' web/index.html
    sed -i".bak" '/src="packages\/browser\/dart.js"/d' web/index.html
    rm web/index.html.bak
fi

./compile_less.sh

# mode puede ser debug|release
echo "Client compilation mode is: $mode"
pub build --mode=$mode
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/

if [[ "$mode" == "release" ]]
    then
    # Revertimos los cambios hechos en release
    git checkout -- web/index.html
fi
