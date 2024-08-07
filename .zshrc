# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/igor-lumx/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

# zshrc
alias zshrc="code ~/Projects/dot-files/.zshrc"
gitdot() {
	TWD=$(pwd); cd ~/Projects/dot-files && git add . && git commit -m $1 && git push && cd $TWD
}

# git
alias gitwip="git add .;git commit -am 'wip' --no-verify"
alias gitamend="git add . && git commit --amend --no-edit"
alias fixandpush="eslint . --ext .js,.jsx --fix && git add . && git commit --amend --no-edit && git push; echo \"eslint and push finished.\" | lmk"
gitmerge() {
  git merge $1 | grep CONFLICT
}

# npm
alias ns="npm run start:debug"
alias nrd="npm run dev"

# Lumx
alias dbpull="npx prisma db pull; echo \"prisma db pull finished.\" | lmk"
alias dbgen="npx prisma generate; echo \"prisma schema generate finished.\" | lmk"
alias freshstart="git checkout .; git pull; nvm use 16; npm i; dbpull; dbgen; nrd"
alias dbpass="unzip ~/Projects/dbpass.zip; cat dbpass.txt | xclip -selection c; rm dbpass.txt; echo 'password copied to clipboard'"
alias goaa="go run cmd/local/main.go"
alias dockerup="docker compose up --detach"

# Other useful stuff 
# play command needs sox installed: sudo apt-get install sox libsox-fmt-all
lmk() { 
    while read input; do
        notify-send "$input";
        play ~/Music/hummus.mp3 &>/dev/null;
    done
}

alias fixkb="setxkbmap -model abnt2 -layout br"
alias c="code ."
alias tasks="echo -n "❌✅🔜" | xclip -selection clipboard; nano +-1 ~/tasks.txt"

# switch between bluetooth headphone profiles and play/pause music
# needs spotify, pulse audio and https://github.com/Rigellute/spotify-tui installed
# needs spotify application to be open beforehand, I suggest adding it to startup 
alias call="\
  spt playback -t > /dev/null;\
  pacmd set-card-profile bluez_card.50_C2_ED_E5_4C_74 handsfree_head_unit &> /dev/null;\
  pacmd set-card-profile bluez_card.50_C2_ED_E4_FA_03 handsfree_head_unit &> /dev/null;\
  pacmd set-card-profile bluez_card.40_35_E6_05_EC_62 handsfree_head_unit &> /dev/null
"
alias music="
  pacmd set-card-profile bluez_card.50_C2_ED_E5_4C_74 a2dp_sink &> /dev/null;\
  pacmd set-card-profile bluez_card.50_C2_ED_E4_FA_03 a2dp_sink &> /dev/null;\
  pacmd set-card-profile bluez_card.40_35_E6_05_EC_62 a2dp_sink &> /dev/null;\
  spt play --uri https://open.spotify.com/playlist/37i9dQZF1DZ06evO4hQGLG > /dev/null
"
# brown noise
alias noise="play -n synth brownnoise lowpass -1 1k gain -10 &"

PROMPT='%{$fg[yellow]%}[%D{%T}] '$PROMPT

export PATH="$PATH:~/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/snap/k9s/current/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/igor-lumx/google-cloud-sdk/path.zsh.inc' ]; then . '/home/igor-lumx/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/igor-lumx/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/igor-lumx/google-cloud-sdk/completion.zsh.inc'; fi

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
