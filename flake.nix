{
  description = "s11c macos nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        with pkgs; [
          miracode
          raycast
          discord
          eza
          z-lua
          bat

          slack
          jira-cli-go
          postman

          jetbrains.webstorm
          gh
          lazygit
        ];

        users.users.marla.home = "/Users/marla";

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      nix = {
        linux-builder.enable = true;
        extraOptions = ''
          extra-platforms = x86_64-darwin aarch64-darwin
        '';
      };


      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system = {
        defaults = {
          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
          };

          dock = {
            autohide = true;
            showhidden = true;
          };

          NSGlobalDomain = {
            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticInlinePredictionEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
            AppleKeyboardUIMode = 3;
            ApplePressAndHoldEnabled = true;
            InitialKeyRepeat = 10;
            KeyRepeat = 1;
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
            _HIHideMenuBar = true;
          };
        };

        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToControl = true;
        };
      };


      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
      in
      {
        darwinConfigurations."s11c-mac-studio" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ 
            configuration 
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.marla = import ./home.nix;
            }
          ];
        };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."s11c-mac-studio".pkgs;
  };
}
