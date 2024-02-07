## Demo

![demo](https://raw.githubusercontent.com/JiagengDing/pictures/main/uPic/uZCp9V.png)

## Structure

```
.
├── default_config
│   └── _machine_specific_default.lua # define some variables for different machines
├── init.lua                          # config portal
├── lazy-lock.json                    # lock file
├── lua
│   ├── config                        
│   │   ├── basic.lua                 # basic config file
│   │   ├── compile.lua               # define compile and run function
│   │   ├── keybindings.lua           # define my keybindings
│   │   └── plugins.lua               # lazynvim config
│   │ 
│   ├── lsp                           # lsp config, works with plugins/lspconfig.lua
│   │   ├── json.lua
│   │   ├── lua.lua
│   │   └── python.lua
│   │ 
│   ├── plugins                       # plugins directory, import to lazynvim automaticlly
│   │   ├── coding.lua
│   │   ├── ...
│   │   ├── ui.lua
│   │   └── visual-multi.lua
│   │ 
│   └── plugins_                      # import to lazynvim manully
│       └── autocomplete.lua
└── README.md
```

## Reference
- [theniceboy/nvim](https://github.com/theniceboy/nvim)
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
