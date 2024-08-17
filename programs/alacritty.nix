{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      shell.program = "${pkgs.nushell}/bin/nu";
      env = {
        "TERM" = "xterm-256color";
      };

      window = {
        opacity = 0.8;
        blur = true;

	dynamic_padding = false;
        padding.x = 0;
        padding.y = 0;
        decorations = "buttonless";
      };

      font = {
        size = 14.0;
      };
    };
  };
}
