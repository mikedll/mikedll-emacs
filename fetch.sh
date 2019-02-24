cat $HOME/Dropbox/common/emacs/mike/mine.txt | awk 'BEGIN {basedir="../../Dropbox/common/emacs/mike/"}; $0 !~ "^#" {print basedir "/" $0}' | xargs cp -t .
