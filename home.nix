{ config, pkgs, lib, ... }:

{
  imports = [
    ./programs/alacritty.nix
    ./programs/nixvim.nix
  ];

  home = {
    stateVersion = "22.05";
    username = "marla";
    homeDirectory = "/Users/marla";
    sessionPath = [ "$HOME/.cargo/bin" ];
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

      initExtra = ''
        setopt autocd # treats `[folder]` as `cd [folder]`

        hash -d vault=$HOME/Documents/Vault
        hash -d nix=$HOME/.config/nix

        PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/scripts
      '';
    };

    nushell = {
      enable = true;
      extraConfig = ''
        # TODO: Add OS check
        # (macos) uses native `open` (https://www.nushell.sh/book/configuration.html#macos-keeping-usr-bin-open-as-open)
        alias nu-open = open
        alias open = ^open

        let carapace_completer = { |spans|
          carapace $spans.0 nushell $spans | from json
        }

        $env.config = {
          show_banner: false,
          completions: {
            case_sensitive: true
            quick: true
            partial: true
            algorithm: "fuzzy"
            external: {
              enable: true
              max_results: 100
              completer: $carapace_completer
            }
          }
        }

        $env.PATH = (
          $env.PATH 
          | split row (char esep) 
          | prepend /usr/local/bin
          | prepend /etc/profiles/per-user/marla/bin/
          # FIXME: | prepend ($env.CARGO_HOME | path join .local bin)
          | prepend ($env.HOME | path join .local bin)
          | uniq # filter so the paths are unique
        )
      '';

      shellAliases = {
        ls = "eza";
        cat = "bat";
        lg = "lazygit";
        sync = "darwin-rebuild switch --flake ${config.xdg.configHome}/nix and source /Users/marla/.zshrc";
        home = "/Users/marla/.local/state/nix/profiles/home-manager/bin/home-manager-generation";
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
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
