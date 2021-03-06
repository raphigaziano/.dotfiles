#! /bin/bash
DIR=~/.dotfiles
ignore=(
    README.rst
    scripts
    bin
    backups
    install.sh
    TODO.rst
)

cd $DIR

for filename in *
do
    # check if the file should be ignored
    shouldIgnore=false
    for ignorename in ${ignore[@]}
    do
        if [[ $filename == $ignorename ]]
        then
            shouldIgnore=true
        fi
    done

    # if you shouldn't ignore, and it's not already linked
    if [ $shouldIgnore == false -a ! -L ~/.$filename ]
    then
        # move old versions to backup dir
        if [ -e ~/.$filename ]
        then
            if [ ! -d $DIR/backup ]
            then
                mkdir $DIR/backups
            fi
            echo ${filename} moved to ${DIR}/backups/${filename}
            mv ~/.$filename $DIR/backups/
        fi
        # create the link
        echo new link ~/.${filename} to ${DIR}/${filename}
        ln -s $DIR/$filename ~/.$filename
    fi
done

# Visible link to bin folder
if [ ! -e ~/bin ]
then
    echo creating local bin folder
    ln -s $DIR/bin ~/bin
fi

# clone vundle (vim plugin manager)
mkdir $DIR/vim/bundle
git clone https://github.com/gmarik/vundle.git $DIR/vim/bundle/vundle
vim +PluginInstall +qall

# source bashrc
source ~/.bashrc
