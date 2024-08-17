{ config, pkgs, lib, nixvim, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    performance = {
      byteCompileLua.enable = true;
      combinePlugins = {
        enable = true;
# standalonePlugins = [ ];
      };
    };

    opts = {
      number = true;
      relativenumber = true;

      signcolumn = "yes"; # always show the signcolumn, otherwise text would be shifted when displaying error icons

        ignorecase = true;
      smartcase = true;

      tabstop = 2;
      shiftwidth = 2;
# softtabstop = 0;
      expandtab = true;
      smarttab = true;

# needs xclip/wl-clipboard
# clipboard = "unnamedplus";

      cursorline = true;
      ruler = true; # shows line/column when searching
        gdefault = true; # global substitution by default

        scrolloff = 5; # scroll offset
    };

    globals.mapleader = " ";

    plugins = {
      bufferline.enable = true; # tabs
        lualine.enable = true; # bottom line
        ts-autotag.enable = true; # treesitter autotag
        nvim-autopairs.enable = true;
      commentary.enable = true; # easy comments
        noice.enable = true; #prettier fancier cmd window
        nix.enable = true;

        none-ls = {
          enable = true;
          settings = {
            cmd = ["bash -c nvim"];
            debug = true;
          };
          sources = {
            formatting = {
              stylua.enable = true;
              shfmt.enable = true;
              nixpkgs_fmt.enable = true;
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
            };

            completion = {
              luasnip.enable = true;
              spell.enable = true;
            };
          };
        };


      toggleterm = {
        enable = true;
        settings = {
          hide_numbers = false;
          autochdir = true;
          close_on_exit = true;
          direction = "vertical";
        };
      };

      gitsigns = {
        enable = true;
        settings.current_line_blame = true;
      };

      which-key = {
        enable = true;
        registrations = {
          "'<leader>fg" = "Find git files with telescope";
          "'<leader>fw" = "Find text with telescope";
          "'<leader>ff" = "Find files with telescope";
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
      };

      illuminate = { # highlights word under cursor
        enable = true;
        underCursor = false;
        filetypesDenylist = [
          "Outline"
            "TelescopePrompt"
            "alpha"
            "harpoon"
            "reason"
        ];
      };
    };
  };
}
