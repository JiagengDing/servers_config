# neofetch
# Setting PATH for Python 3.8
# The original version is saved in .zprofile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
# PATH="/Users/JiagengDing/Library/Python/3.8/bin:${PATH}"
export PATH
#export ZDOTDIR=$HOME/.config/zsh
rm -f $ZINIT[BIN_DIR]/*.zwc

export PATH=$PATH:/Applications/MATLAB_R2018a.app/bin/

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
