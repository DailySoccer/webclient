#!/bin/sh

mode="release"

if [[ $1 != "" ]]
    then
        mode=$1
fi

# Cambios al index.html
sed -i".bak" '/<!--/{ N; N; s/.*\n\(.*main.dart.js.*\)\n.*-->.*/\1/; }' web/index.html
sed -i".bak" '/src="main.dart"/d' web/index.html
sed -i".bak" '/src="packages\/browser\/dart.js"/d' web/index.html
rm web/index.html.bak

# Compilamos nuestros less a css
./compile_less.sh

# mode puede ser debug|release
echo "Client compilation mode is: $mode"
dart cache_gen.dart
pub build --mode=$mode
rsync -r  -v --copy-unsafe-links build/web/. ../backend/public/

# Revertimos los cambios hechos al index.html
git checkout -- web/index.html