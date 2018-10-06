#!/bin/bash
input='data'
iSrc=0
iDest=1
if [[ $1 == 'import' || $1 == 'i' ]]
then
	iSrc=1
	iDest=0
	sh code/install_extension.sh
	dconf load /com/gexperts/Tilix/ < tilix/tilix.dconf 
else
	echo "#!/bin/sh" > code/install_extension.sh
	code --list-extensions | xargs -L 1 echo code --install-extension >> code/install_extension.sh
	dconf dump /com/gexperts/Tilix/ > tilix/tilix.dconf 
fi
while IFS='' read -r line || [[ -n "$line" ]]; do
	IFS=';' read -r -a arg <<< $line
	eval mkdir -p $(dirname ${arg[$iDest]})
	eval cp -rvT ${arg[$iSrc]} ${arg[$iDest]} 1> /dev/null
done < "$input"

# Source : https://stackoverflow.com/questions/5748216/tilde-expansion-not-working-in-bash
# Source : https://stackoverflow.com/questions/10929453/read-a-file-line-by-line-assigning-the-value-to-a-variable
# Source : https://stackoverflow.com/questions/10586153/split-string-into-an-array-in-bash