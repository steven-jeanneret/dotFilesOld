#!/bin/sh

echo "#!/bin/sh" > install_extension.sh
code --list-extensions | xargs -L 1 echo code --install-extension >> install_extension.sh