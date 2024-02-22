# README

This is my personal neovim config; initally bootstrapped from https://github.com/nvim-lua/kickstart.nvim

**Why are you using Neovim**

I spend alot of time jumping between languages. My VSCode configruation is nice for JavaScript projects but kind of sucks for everything else. I really can't stand having to pop open a new IntelliJ IDE for every language I'm working with at the moment. Plus I haven't taken the time to dive into how any of these IDE's really go about how configrue themselves (skill issues); nor do I care. I just want to write code. These are the challeges I am aiming to solve with my neovim config. (but Zod looks promising) 

## Setup 

Clone this repo where ever your neovim is looking for its config

```shell
git clone https://github.com/9mbs/neovim-config.git ~/.config/nvim

# pop open Neovim and load the plugins
nvim
```

If your using a terminal that does not support true colors; such as the default MacOS terminal you may need to [use a different terminal](https://stackoverflow.com/questions/49408010/neovim-display-issue-on-mac-os-x). 


## More Personization (iTerm2 Profile Configuration)

I'm using [iTerm2](https://iterm2.com/) after using the default terminal for the last 6 years. To be honest, iTerm2 feels very similar; just better (at the least; in the sense that it supports true colors.). 


### Change the default font in iTerm2 (MacOS)

1. Add a font you like (FiraCode is slick) - https://www.nerdfonts.com/font-downloads
2. Upload the font family to the fontbook app.
3. Open iTerm2, in the menu bar select "Profiles" 
4. In the "Profiles" window, select "Edit Profiles..."
5. In the new "Preferences" window, select the "Text" tab.
6. Find in the "Font" tab and select your new font.
7. (Optional) I also change the default text size from 12px to 14px or 16px because spending so much time in any IDE can be naturally strenuous

### iTerm2 Profile Configuration

1. Open iTerm2, in the menu bar select "Profiles" 
2. In the "Profiles" window, select "Edit Profiles..."
3. In the new "Preferences" window, select the "Colors" tab.
4. Change the Background color to `#1F1F1F` 



