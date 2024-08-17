{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;
    editorconfig.enable = true;

    performance = {
      byteCompileLua.enable = true;
      combinePlugins = {
        enable = true;
      };
    };

    globals.mapleader = " ";
    opts = {
      number = true;
      relativenumber = true;

      signcolumn = "yes"; # always show the signcolumn, otherwise text would be shifted when displaying error icons

      ignorecase = true;
      smartcase = true;
      autoindent = true;

      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smarttab = true;

      clipboard = "unnamedplus"; # needs clip/wl-clipboard

      cursorline = true; # highlights current line
      ruler = true; # shows line/column when searching
      gdefault = true; # global substitution by default

      scrolloff = 5; # scroll offset

      # staline requirements
      laststatus = 2;
      showtabline = 2;
      termguicolors = true;
    };


    plugins = {
      ts-autotag.enable = true; # treesitter autotag
      nvim-autopairs.enable = true;
      commentary.enable = true; # easy comments
      nix.enable = true;
      cmp-emoji.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      trouble.enable = true; # diagnostics
      lsp-lines.enable = true;
      lsp-format.enable = true;
      # ? helm.enable = true;
      treesitter-context.enable = true;
      lazygit.enable = true;
      nix-develop.enable = true;

      transparent = {
        enable = true;
        settings = {
          exclude_groups = [
            "CursorLine"
            "CursorLineNC"
          ];
          extra_groups = [
            "NormalFloat"
            "BufferLineTabClose"
            "BufferLineBufferSelected"
            "BufferLineFill"
            "BufferLineBackground"
            "BufferLineSeparator"
            "BufferLineIndicatorSelected"
            "NonText"
          ];
        };

      };

      persistence = {
        enable = true;
        options = [ "buffers" "curdir" "folds" "globals" "resize" "tabpages" "winpos" "winsize" ];
      };

      bufferline = {
        enable = true;
        settings.options = {
          color_icons = false;
          show_buffer_icons = false;
          separator_style = "thin";
          diagnostics = "nvim_lsp";
          mode = "buffers";
          buffer_close_icon = "X";
          close_icon = "X";
          modified_icon = "M";
        };
      };

      lualine = {
        enable = false;
        globalstatus = true;
        iconsEnabled = false;
        extensions = [ "fzf" ];
        disabledFiletypes = {
          statusline = [ "startup" "alpha" ];
        };
        sectionSeparators = {
          left = ">";
          right = "<";
        };
        componentSeparators = {
          left = " > ";
          right = " < ";
        };
      };

      noice = {
        enable = true;
        notify.enabled = false;
        messages.enabled = true;
        lsp = {
          message.enabled = true;
          progress = {
            enabled = false;
            view = "mini";
          };
        };
        popupmenu = {
          enabled = true;
          backend = "nui";
        };
        format = {
          filter = {
            pattern = [
              ":%s*%%s*s:%s*"
              ":%s*%%s*s!%s*"
              ":%s*%%s*s/%s*"
              "%s*s:%s*"
              ":%s*s!%s*"
              ":%s*s/%s*"
            ];
            icon = "";
            lang = "regex";
          };
          replace = {
            pattern = [
              ":%s*%%s*s:%w*:%s*"
              ":%s*%%s*s!%w*!%s*"
              ":%s*%%s*s/%w*/%s*"
              "%s*s:%w*:%s*"
              ":%s*s!%w*!%s*"
              ":%s*s/%w*/%s*"
            ];
            icon = "";
            lang = "regex";
          };
        };
      };

      none-ls = {
        enable = true;
        enableLspFormat = true;
        settings = {
          cmd = [ "bash -c nvim" ];
          debug = true;
          updateInInsert = false;
        };
        sources = {
          code_actions = {
            gitsigns.enable = true;
            statix.enable = true;
          };

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
            spell.enable = true;
          };
        };
      };

      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          tsserver.enable = true;
          cssls.enable = true;
          tailwindcss.enable = true;
          html.enable = true;
          astro.enable = true;
          marksman.enable = true;
          nil-ls.enable = true;
          bashls.enable = true;
          yamlls.enable = true;

          lua-ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
        };

        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "goto Definition";
            };
            gr = {
              action = "references";
              desc = "goto References";
            };
            gD = {
              action = "declaration";
              desc = "goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "type Definition";
            };
            K = {
              action = "hover";
              desc = "hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "workspace Symbol";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "rename";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "line Diagnostics";
            };
            "[d" = {
              action = "goto_next";
              desc = "next Diagnostic";
            };
            "]d" = {
              action = "goto_prev";
              desc = "previous Diagnostic";
            };
          };
        };
      };

      lspsaga = {
        enable = true;
        beacon.enable = true;
        ui = {
          devicon = false;
          border = "none";
          codeAction = " ! ";
          actionfix = "fix";
          collapse = "v";
          expand = "^";
        };
        diagnostic = {
          borderFollow = true;
          diagnosticOnlyCurrent = false;
          showCodeAction = true;
        };
        symbolInWinbar = {
          enable = true; # Breadcrumbs
          hideKeyword = true;
          separator = " > ";
          showFile = false;
        };
        codeAction = {
          extendGitSigns = false;
          showServerName = true;
          onlyInCursor = true;
          numShortcut = true;
          keys = {
            exec = "<CR>";
            quit = [
              "<Esc>"
              "q"
            ];
          };
        };
        lightbulb = {
          enable = false;
          sign = false;
          virtualText = false;
        };
        outline = {
          autoClose = true;
          autoPreview = true;
          closeAfterJump = true;
          layout = "float"; # normal or float
          winPosition = "right"; # left or right
          keys = {
            jump = "e";
            quit = "q";
            toggleOrJump = "o";
          };
        };
        scrollPreview = {
          scrollDown = "<C-f>";
          scrollUp = "<C-b>";
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          hide_numbers = false;
          autochdir = true;
          close_on_exit = true;
          direction = "horizontal";
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          numhl = true;
          signcolumn = false;
          trouble = true;
        };
      };

      which-key = {
        enable = true;
        settings = {
          icons.rules = false;
          expand = 1;
          notify = false;
          preset = false;
          replace = {
            desc = [
              [ "<leader>" "<space>" ]
              [ "<[cC][rR]>" "<return>" ]
              [ "<[tT][aA][bB]" "<tab>" ]
              [ "[bB][sS]" "<backspace>" ]
            ];
          };
          spec = [
            {
              __unkeyed-1 = "<leader>b";
              group = "buffers";
            }
            {
              __unkeyed-2 = "<leader>c";
              group = "code";
            }
            {
              __unkeyed-3 = "<leader>g";
              group = "goto";
            }
          ];
          win = {
            padding = [ 0 0 ];
            title = false;
          };
          layout = {
            spacing = 2;
            width.max = 400;
            width.min = 200;
          };
        };
      };

      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          fzf-native.enable = true;
        };
        settings = {
          defaults.layout_config.horizontal.prompt_position = "top";
          sorting_strategy = "ascending";
        };
        keymaps = {
          "<leader><space>" = {
            action = "find_files";
            options.desc = "find project files";
          };
        };
      };

      illuminate = {
        # highlights word under cursor
        enable = true;
        underCursor = false;
        filetypesDenylist = [
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "reason"
          "oil"
        ];
      };

      hardtime = {
        enable = false;
        enabled = false;
        disableMouse = true;
        hint = true;
        maxCount = 4;
        maxTime = 100;
        restrictionMode = "hint";
      };

      alpha = {
        enable = true;
        theme = null;
        iconsEnabled = false;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Type";
              position = "center";
            };
            type = "text";
            val = [
              "nixvim"
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                on_press = {
                  __raw = "function() vim.cmd[[ene]] end";
                };
                opts = {
                  shortcut = "n";
                  position = "center";
                };
                type = "button";
                val = "  new file";
              }
              {
                on_press = {
                  __raw = "function() vim.cmd[[qa]] end";
                };
                opts = {
                  shortcut = "q";
                  position = "center";
                };
                type = "button";
                val = " quit nixvim";
              }
            ];
          }
        ];
      };

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          experimental = { ghost_text = true; };
          formatting = { fields = [ "kind" "abbr" "menu" ]; };
          performance = {
            debounce = 60;
            fetchingTimeout = 200;
            maxViewEntries = 30;
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "emoji"; }
            {
              name = "buffer"; # text withing current buffer
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            {
              name = "path"; # file system paths
              keywordLenght = 3;
            }
          ];

          window = {
            completion = {
              side_padding = 0;
              scrollbar = false;
            };
          };

          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
            "<S-Tab>" = "cmp.mapping.select_next_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };

      schemastore = {
        enable = true;
        yaml.enable = true;
        json.enable = true;
      };

      fidget = {
        enable = true;
        logger = {
          level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          floatPrecision = 0.01; # Limit the number of decimals displayed for floats
        };
        progress = {
          pollRate = 0; # How and when to poll for progress messages
          suppressOnInsert = true; # Suppress new messages while in insert mode
          ignoreDoneAlready = false; # Ignore new tasks that are already complete
          ignoreEmptyMessage = false; # Ignore new tasks that don't contain a message
          clearOnDetach =
            # Clear notification group when LSP server detaches
            ''
              function(client_id)
                local client = vim.lsp.get_client_by_id(client_id)
                return client and client.name or nil
              end
            '';
          notificationGroup =
            # How to get a progress message's notification group key
            ''
              function(msg) return msg.lsp_client.name end
            '';
          ignore = [ ]; # List of LSP servers to ignore
          lsp = {
            progressRingbufSize = 0; # Configure the nvim's LSP progress ring buffer size
          };
          display = {
            renderLimit = 16; # How many LSP messages to show at once
            doneTtl = 3; # How long a message should persist after completion
            doneIcon = ""; # Icon shown when all LSP progress tasks are complete
            doneStyle = "Constant"; # Highlight group for completed LSP tasks
            progressTtl = "math.huge"; # How long a message should persist when in progress
            progressIcon = {
              pattern = "dots";
              period = 1;
            }; # Icon shown when LSP progress tasks are in progress
            progressStyle = "WarningMsg"; # Highlight group for in-progress LSP tasks
            groupStyle = "Title"; # Highlight group for group name (LSP server name)
            iconStyle = "Question"; # Highlight group for group icons
            priority = 30; # Ordering priority for LSP notification group
            skipHistory = true; # Whether progress notifications should be omitted from history
            formatMessage = ''
              require ("fidget.progress.display").default_format_message
            ''; # How to format a progress message
            formatAnnote = ''
              function (msg) return msg.title end
            ''; # How to format a progress annotation
            formatGroupName = ''
              function (group) return tostring (group) end
            ''; # How to format a progress notification group's name
            overrides = {
              rust_analyzer = {
                name = "rust-analyzer";
              };
            }; # Override options from the default notification config
          };
        };
        notification = {
          pollRate = 10; # How frequently to update and render notifications
          filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          historySize = 128; # Number of removed messages to retain in history
          overrideVimNotify = true;
          redirect = ''
            function(msg, level, opts)
            if opts and opts.on_open then
              return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
            end
            end
          '';
          configs = {
            default = "require('fidget.notification').default_config";
          };

          window = {
            normalHl = "Comment";
            winblend = 0;
            border = "none"; # none, single, double, rounded, solid, shadow
            zindex = 45;
            maxWidth = 0;
            maxHeight = 0;
            xPadding = 1;
            yPadding = 0;
            align = "bottom";
            relative = "editor";
          };
          view = {
            stackUpwards = true; # Display notification items from bottom to top
            iconSeparator = " "; # Separator between group name and icon
            groupSeparator = "---"; # Separator between notification groups
            groupSeparatorHl =
              # Highlight group used for group separator
              "Comment";
          };
        };
      };

      navic = {
        enable = true;
        separator = " > ";
        highlight = true;
        depthLimit = 2;
        lsp.autoAttach = true;
        icons = {
          Array = "> ";
          Boolean = "> ";
          Class = "> ";
          Constant = "> ";
          Constructor = "> ";
          Enum = "> ";
          EnumMember = "> ";
          Event = "> ";
          Field = "> ";
          File = "> ";
          Function = "> ";
          Interface = "> ";
          Key = "> ";
          Method = "> ";
          Module = "> ";
          Namespace = "> ";
          Null = "> ";
          Number = "> ";
          Object = "> ";
          Operator = "> ";
          Package = "> ";
          String = "> ";
          Struct = "> ";
          TypeParameter = "> ";
          Variable = "> ";
        };
      };

      navbuddy = {
        enable = true;
        lsp.autoAttach = true;
        icons = {
          Array = "> ";
          Boolean = "> ";
          Class = "> ";
          Constant = "> ";
          Constructor = "> ";
          Enum = "> ";
          EnumMember = "> ";
          Event = "> ";
          Field = "> ";
          File = "> ";
          Function = "> ";
          Interface = "> ";
          Key = "> ";
          Method = "> ";
          Module = "> ";
          Null = "> ";
          Number = "> ";
          Object = "> ";
          Operator = "> ";
          Package = "> ";
          Property = "> ";
          String = "> ";
          Struct = "> ";
          TypeParameter = "> ";
          Variable = "> ";
        };
        nodeMarkers.icons = {
          branch = " > ";
          leaf = " ";
          leafSelected = " > ";
        };
      };

      treesitter = {
        enable = true;
        folding = false;
        nixvimInjections = false; # doesn't work with poimandres-nvim
        nixGrammars = false; # doesn't work with poimandres-nvim

        settings = {
          auto_install = true; # required because of poimandres-nvim
          indent.enable = true;
          highlight.enable = true;
        };
      };

      treesitter-textobjects = {
        enable = false;
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "ii" = "@conditional.inner";
            "ai" = "@conditional.outer";
            "il" = "@loop.inner";
            "al" = "@loop.outer";
            "at" = "@comment.outer";
          };
        };
        move = {
          enable = true;
          gotoNextStart = {
            "]m" = "@function.outer";
            "]]" = "@class.outer";
          };
          gotoNextEnd = {
            "]M" = "@function.outer";
            "][" = "@class.outer";
          };
          gotoPreviousStart = {
            "[m" = "@function.outer";
            "[[" = "@class.outer";
          };
          gotoPreviousEnd = {
            "[M" = "@function.outer";
            "[]" = "@class.outer";
          };
        };
        swap = {
          enable = true;
          swapNext = {
            "<leader>a" = "@parameters.inner";
          };
          swapPrevious = {
            "<leader>A" = "@parameter.outer";
          };
        };

      };

      neocord = {
        enable = true;
        settings = {
          auto_update = true;
          enable_line_number = true;
        };
      };

      oil = {
        enable = true;
        settings = {
          useDefaultKeymaps = true;
          deleteToTrash = true;
          columns = [ "type" "size" "permissions" ];
          view_options.show_hidden = true;
          constrain_cursor = "name";
          preview.border = "rounded";
          keymaps_help.border = "rounded";
          win_options = {
            conceallevel = 3;
          };
          float = {
            padding = 4;
            maxWidth = 0; # ''math.ceil(vim.o.lines * 0.8 - 4)'';
            maxHeight = 0; # ''math.ceil(vim.o.columns * 0.8)'';
            border = "rounded"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
            winOptions = {
              winblend = 0;
            };
          };
          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "<C-\\>" = "actions.select_vsplit";
            "<C-enter>" = "actions.select_split"; # this is used to navigate left
            "<C-t>" = "actions.select_tab";
            "<C-v>" = "actions.preview";
            "<C-c>" = "actions.close";
            "<C-r>" = "actions.refresh";
            "-" = "actions.parent";
            "_" = "actions.open_cwd";
            "`" = "actions.cd";
            "~" = "actions.tcd";
            "gs" = "actions.change_sort";
            "gx" = "actions.open_external";
            "g." = "actions.toggle_hidden";
            "q" = "actions.close";
          };
        };
      };

      nvim-lightbulb = {
        enable = true;
        settings = {
          autocmd = {
            enabled = true;
            updatetime = 200;
          };
          line.enabled = false;
          float.enabled = false;
          number.enabled = false;
          sign.enabled = false;
          status_text.enabled = false;

          virtual_text = {
            enabled = true;
            text = "  !";
          };
        };
      };
    };

    extraConfigLua = ''
      vim.cmd('colorscheme poimandres')
      local opt = { noremap = true }
      local telescope = require("telescope")
      telescope.load_extension("lazygit")
      telescope.setup({})

      local cmp = require'cmp'

      require("staline").setup({
        sections = {
          left = { "-mode", " ", "branch", " ", "cwd" },
          mid = { "" },
          right = { "lsp", " ", "lsp_name", " ", "line_column" },
        },
        inactive_sections = {
          left = { "branch" },
          mid = { "" },
          right = { "lsp_name", " ", "line_column" },
        },
        defaults = {
          left_separator = " ",
          right_separator = "  ",
          branch_symbol = "b ",
          mod_symbol = "",
          line_column = "[%l/%L]",
          inactive_color = "#80a6f2", --#303030 is the default
          inactive_bgcolor = "none",
          bg = "none",
          true_colors = true,
          lsp_client_symbol = "",
        },
        special_table = {
          TelescopePrompt = { "telescope", "" },
          oil = { "oil", "" },
          lazygit = { "lazygit", "" },
        },
        lsp_symbols = {
          Error = "E ",
          Info = "I ",
          Warn = "W ",
          Hint = "H ",
        };
        mode_icons = {
          ["n"] = "NORMAL",
          ["no"] = "NORMAL",
          ["nov"] = "NORMAL",
          ["noV"] = "NORMAL",
          ["niI"] = "NORMAL",
          ["niR"] = "NORMAL",
          ["niV"] = "NORMAL",
          ["i"] = "INSERT",
          ["ic"] = "INSERT",
          ["ix"] = "INSERT",
          ["s"] = "INSERT",
          ["S"] = "INSERT",
          ["v"] = "VISUAL",
          ["V"] = "VISUAL",
          [""] = "VISUAL",
          ["r"] = "REPLACE",
          ["r?"] = "REPLACE",
          ["R"] = "REPLACE",
          ["c"] = "COMMAND",
          ["t"] = "TERMINAL",
        },
      })
    '';

    extraPlugins = with pkgs.vimPlugins; [
      vim-be-good
      poimandres-nvim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "staline.nvim";
        version = "2024-02-05";
        src = pkgs.fetchFromGitHub {
          owner = "tamton-aquib";
          repo = "staline.nvim";
          rev = "d337bc9b343df3328921ef4c3f8ff604102d0201";
          hash = "sha256-HkuVio/F8HOb6k9N8LkYdQ1vheuyjrqP25RforoWZSk=";
        };
      })
    ];

    extraPackages = with pkgs; [
      shfmt
    ];

    keymaps = [
      {
        mode = "n";
        key = "<Tab>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "cycle to next buffer";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "cycle to previous buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "delete buffer";
      }
      {
        mode = "n";
        key = "<leader>br";
        action = "<cmd>BufferLineCloseRight<cr>";
        options.desc = "delete buffers to the right";
      }
      {
        mode = "n";
        key = "<leader>bl";
        action = "<cmd>BufferLineCloseLeft<cr>";
        options.desc = "delete buffers to the right";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>BufferLineCloseOthers<cr>";
        options.desc = "delete buffers to the right";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>BufferLineTogglePin<cr>";
        options.desc = "toggle pin";
      }
      {
        mode = "n";
        key = "<leader>bP";
        action = "<cmd>BufferLineGroupClose ungrouped<cr>";
        options.desc = "delete non-pinned buffers";
      }

      {
        mode = "n";
        key = "<leader>gi";
        action = "<cmd>Navbuddy<cr>";
        options.desc = "open navbuddy";
      }

      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "open lazygit";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>LazyGitFilter<cr>";
        options.desc = "open project commits";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>LazyGitCurrentFile<cr>";
        options.desc = "open lazygit in the project root of the current file";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>LazyGitFilterCurrentFile<cr>";
        options.desc = "open buffer commits";
      }
      {
        mode = "n";
        key = "<leader>gtd";
        action = "<cmd>Gitsigns toggle_deleted<cr>";
        options.desc = "toggle deleted lines preview";
      }
      {
        mode = "n";
        key = "<leader>gh";
        action = "<cmd>Gitsigns setqflist<cr><C-w><C-w>";
        options.desc = "open preview of hunks in current file";
      }

      {
        mode = "n";
        key = "-";
        action = ":Oil<CR>";
        options = {
          desc = "open parent directory";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options = {
          desc = "code action";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<CR>";
        action = "<cmd>Lspsaga code_action<CR>";
        options = {
          desc = "code action";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<C-CR>";
        action = "<cmd>Lspsaga code_action<CR>";
        options = {
          desc = "code action";
          silent = true;
        };
      }
    ];
  };
}
