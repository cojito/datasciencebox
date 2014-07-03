c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

workon() { source activate $1; }
_workon() { _files -W ~/anaconda/envs -/; }
compdef _workon workon