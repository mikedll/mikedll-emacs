
These are some sample emacs config files I use on a daily basis, and
also that I use to give emacs tutorials. The most interesting is
probably emacs-extensions, which I've used to drive Clojure and Ruby
REPL-interpretters.
      
The Windows help also shows how to capture the Win key, or how to mess
with windows services from emacs (makes shell calls to the sc command
line tool).

# Updating from Dropbox (for Mike):

This can be used to update these files from a Dropbox-supervised
directory.

    > cat ../../Dropbox/common/emacs/mike/mine.txt | awk 'BEGIN {basedir="../../Dropbox/common/emacs/mike/"}; $0 !~ "^#" {print basedir "/" $0}' | xargs cp -t . 

