{ config, pkgs, lib, ... }:

{
  home = {
    stateVersion = "22.05";
    username = "marla";
    homeDirectory = "/Users/marla";
  };

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ls = "eza";
        cat = "bat";
        lg = "lazygit";
        update = "darwin-rebuild switch --flake ${config.xdg.configHome}/nix && source /Users/marla/.zshrc";
        home = "/Users/marla/.local/state/nix/profiles/home-manager/bin/home-manager-generation";
      };

      history = {
        size = 10000;
        path = "${config.xdg.configHome}/zsh/history";
      };
    };

    nushell = {
      enable = true;
      extraConfig = ''
        let carapace_completer = { |spans|
          carapace $spans.0 nushell $spans | from json
        }

        $env.config = {
          show_banner: true,
          completions: {
            case_sensitive: true
            quick: true
            partial: ture
            algorithm: "fuzzy"
            external: {
              enable: true
              max_results: 100
              completer: $carapac_completer
            }
          }

          $env.PATH = ( $env.PATH | split row (char esep) | append /usr/bin/env )
        }
      '';

      shellAliases = {
        ls = "eza";
        cat = "bat";
        lg = "lazygit";
        update = "darwin-rebuild switch --flake ${config.xdg.configHome}/nix && source /Users/marla/.zshrc";
        home = "/Users/marla/.local/state/nix/profiles/home-manager/bin/home-manager-generation";
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        directory = {
          fish_style_pwd_dir_length = 1;
          truncation_length = 2;
        };
        character = {
          success_symbol = ">(bold green)";
          error_symbol = ">(bold red)";
        };
      };
    };



    git = {
      enable = true;
      userName = "Marla Albuquerque";
      userEmail = "marla@albuque.com";

      extraConfig = {
        push = { autoSetupRemote = true; };
      };
    };


    # disabled until it's fixed https://discourse.nixos.org/t/cannot-login-with-gh-cli/16601
    # gh = {
    #   enable = true;
    # };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      extraConfig = ''
        set autoindent noexpandtab hlsearch list number relativenumber showcmd splitright
        set tabstop=2
        set shiftwidth=2
        set completeopt=menuone
        set encoding=utf-8

        let mapleader = ' '
      '';

      plugins = with pkgs.vimPlugins; [
        vim-sensible
        vim-surround
        ReplaceWithRegister
        polyglot
        fzfWrapper
        deoplete-nvim
      ];
    };
  };

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  home.packages = with pkgs; [
    coreutils
    curl
    wget

    # dev related
    jq
    fd

    # nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    # niv # easy dependency management for nix projects
    # nodePackages.node2nix
  ] ++ lib.optionals stdenv.isDarwin [
    m-cli # useful macOS CLI commands

  ];
}
