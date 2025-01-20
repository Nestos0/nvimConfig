return {
    {
        "Nestos0/multiple-cursors.nvim",
        version = "*", -- Use the latest tagged version
         opts = function()
            local normal_mode_motion = require("multiple-cursors.normal_mode.motion")
            local normal_mode_backspace = require("multiple-cursors.normal_mode.backspace")
            local normal_mode_delete_yank_put = require("multiple-cursors.normal_mode.delete_yank_put")
            local normal_mode_edit = require("multiple-cursors.normal_mode.edit")
            local normal_mode_mode_change = require("multiple-cursors.normal_mode.mode_change")

            local insert_mode_motion = require("multiple-cursors.insert_mode.motion")
            local insert_mode_nonprinting = require("multiple-cursors.insert_mode.nonprinting")
            local insert_mode_special = require("multiple-cursors.insert_mode.special")
            local insert_mode_escape = require("multiple-cursors.insert_mode.escape")

            local visual_mode_modify_area = require("multiple-cursors.visual_mode.modify_area")
            local visual_mode_delete_yank_change = require("multiple-cursors.visual_mode.delete_yank_change")
            local visual_mode_edit = require("multiple-cursors.visual_mode.edit")
            local visual_mode_escape = require("multiple-cursors.visual_mode.escape")

            local opts = {

                default_key_maps = {

                    -- Normal and visual mode motion ---------------------------------------------

                    -- Up/down
                    { { "n", "x" }, { "u", "<Up>" },                   normal_mode_motion.k },
                    { { "n", "x" }, { "e", "<Down>" },                 normal_mode_motion.j },
                    { { "n", "x" }, "-",                               normal_mode_motion.minus },
                    { { "n", "x" }, { "+", "<CR>", "<kEnter>" },       normal_mode_motion.plus },
                    { { "n", "x" }, "_",                               normal_mode_motion.underscore },

                    -- Left/right
                    { { "n", "x" }, { "n", "<Left>" },                 normal_mode_motion.h },
                    { { "n", "x" }, "<BS>",                            normal_mode_backspace.bs },
                    { { "n", "x" }, { "i", "<Right>", "<Space>" },     normal_mode_motion.l },
                    { { "n", "x" }, { "0", "<Home>" },                 normal_mode_motion.zero },
                    { { "n", "x" }, { "^", "<S-n>" },                  normal_mode_motion.caret },
                    { { "n", "x" }, { "$", "<End>", "<S-i>" },         normal_mode_motion.dollar },
                    { { "n", "x" }, "|",                               normal_mode_motion.bar },
                    { { "n", "x" }, "f",                               normal_mode_motion.f },
                    { { "n", "x" }, "F",                               normal_mode_motion.F },
                    { { "n", "x" }, "t",                               normal_mode_motion.t },
                    { { "n", "x" }, "T",                               normal_mode_motion.T },

                    -- Text object motion
                    { { "n", "x" }, { "l", "<S-Right>", "<C-Right>" }, normal_mode_motion.w },
                    { { "n", "x" }, "L",                               normal_mode_motion.W },
                    { { "n", "x" }, "k",                               normal_mode_motion.e },
                    { { "n", "x" }, "K",                               normal_mode_motion.E },
                    { { "n", "x" }, { "b", "<S-Left>", "<C-Left>" },   normal_mode_motion.b },
                    { { "n", "x" }, "B",                               normal_mode_motion.B },
                    { { "n", "x" }, "gl",                              normal_mode_motion.ge },
                    { { "n", "x" }, "gL",                              normal_mode_motion.gE },

                    -- Other
                    { { "n", "x" }, "%",                               normal_mode_motion.percent },
                    { "n",          "gg",                              normal_mode_motion.gg },
                    { "n",          "G",                               normal_mode_motion.G },


                    -- Normal mode edit ----------------------------------------------------------

                    -- Delete, yank, put
                    { "n",          { "x", "<Del>" },                  normal_mode_delete_yank_put.x },
                    { "n",          "X",                               normal_mode_delete_yank_put.X },
                    { "n",          "d",                               normal_mode_delete_yank_put.d },
                    { "n",          "dd",                              normal_mode_delete_yank_put.dd },
                    { "n",          "D",                               normal_mode_delete_yank_put.D },
                    { "n",          "y",                               normal_mode_delete_yank_put.y },
                    { "n",          "yy",                              normal_mode_delete_yank_put.yy },
                    { "n",          "p",                               normal_mode_delete_yank_put.p },
                    { "n",          "P",                               normal_mode_delete_yank_put.P },

                    -- Replace characters
                    { "n",          "r",                               normal_mode_edit.r },

                    -- Indentation
                    { "n",          ">>",                              normal_mode_edit.indent },
                    { "n",          "<<",                              normal_mode_edit.deindent },

                    -- Join lines
                    { "n",          "J",                               normal_mode_edit.J },
                    { "n",          "gJ",                              normal_mode_edit.gJ },

                    -- Change case
                    { "n",          "gu",                              normal_mode_edit.gu },
                    { "n",          "gU",                              normal_mode_edit.gU },
                    { "n",          "g~",                              normal_mode_edit.g_tilde },

                    -- Repeat
                    { "n",          ".",                               normal_mode_edit.dot },


                    -- Normal mode mode change ---------------------------------------------------

                    -- To insert mode
                    { "n",          "a",                               normal_mode_mode_change.a },
                    { "n",          "A",                               normal_mode_mode_change.A },
                    { "n",          { "w", "<Insert>" },               normal_mode_mode_change.i },
                    { "n",          "W",                               normal_mode_mode_change.I },
                    { "n",          "o",                               normal_mode_mode_change.o },
                    { "n",          "O",                               normal_mode_mode_change.O },
                    { "n",          "c",                               normal_mode_mode_change.c },
                    { "n",          "cc",                              normal_mode_mode_change.cc },
                    { "n",          "C",                               normal_mode_mode_change.C },
                    { "n",          "s",                               normal_mode_mode_change.s },

                    -- To visual mode
                    { "n",          "v",                               normal_mode_mode_change.v },

                    -- Insert (and replace) mode -------------------------------------------------

                    -- Motion
                    { "i",          "<Up>",                            insert_mode_motion.up },
                    { "i",          "<Down>",                          insert_mode_motion.down },
                    { "i",          "<Left>",                          insert_mode_motion.left },
                    { "i",          "<Right>",                         insert_mode_motion.right },
                    { "i",          "<Home>",                          insert_mode_motion.home },
                    { "i",          "<End>",                           insert_mode_motion.eol },
                    { "i",          "<C-Left>",                        insert_mode_motion.word_left },
                    { "i",          "<C-Right>",                       insert_mode_motion.word_right },

                    -- Non-printing characters
                    { "i",          { "<BS>", "<C-h>" },               insert_mode_nonprinting.bs },
                    { "i",          "<Del>",                           insert_mode_nonprinting.del },
                    { "i",          { "<CR>", "<kEnter>" },            insert_mode_nonprinting.cr },
                    { "i",          "<Tab>",                           insert_mode_nonprinting.tab },

                    -- Special
                    { "i",          "<C-w>",                           insert_mode_special.c_w },
                    { "i",          "<C-t>",                           insert_mode_special.c_t },
                    { "i",          "<C-d>",                           insert_mode_special.c_d },

                    -- Exit
                    { "i",          "<Esc>",                           insert_mode_escape.escape },


                    -- Visual mode ---------------------------------------------------------------

                    -- Modify area
                    { "x",          "o",                               visual_mode_modify_area.o },
                    { "x",          "a",                               visual_mode_modify_area.a },
                    { "x",          "w",                               visual_mode_modify_area.i },

                    -- Delete, yank, change
                    { "x",          { "d", "<Del>" },                  visual_mode_delete_yank_change.d },
                    { "x",          "y",                               visual_mode_delete_yank_change.y },
                    { "x",          "c",                               visual_mode_delete_yank_change.c },

                    -- Indentation
                    { "x",          ">",                               visual_mode_edit.indent },
                    { "x",          "<",                               visual_mode_edit.deindent },

                    -- Join lines
                    { "x",          "l",                               visual_mode_edit.J },
                    { "x",          "gL",                              visual_mode_edit.gJ },

                    -- Change case
                    { "x",          "j",                               visual_mode_edit.u },
                    { "x",          "J",                               visual_mode_edit.U },
                    { "x",          "~",                               visual_mode_edit.tilde },
                    { "x",          "gj",                              visual_mode_edit.gu },
                    { "x",          "gJ",                              visual_mode_edit.gU },
                    { "x",          "g~",                              visual_mode_edit.g_tilde },

                    -- Exit
                    { "x",          { "<Esc>", "v" },                  visual_mode_escape.escape },

                }
            }
            return opts
        end,
        -- This causes the plugin setup function to be called
        keys = {
            { "<C-e>",  "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" },      desc = "Add cursor and move down" },
            { "<C-u>",  "<Cmd>MultipleCursorsAddUp<CR>",   mode = { "n", "x" },      desc = "Add cursor and move up" },

            { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>",   mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
            {
                "<C-Down>",
                "<Cmd>MultipleCursorsAddDown<CR>",
                mode = { "n", "i", "x" },
                desc = "Add cursor and move down",
            },

            {
                "<C-LeftMouse>",
                "<Cmd>MultipleCursorsMouseAddDelete<CR>",
                mode = { "n", "i" },
                desc = "Add or remove cursor",
            },

            { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>",    mode = { "n", "x" }, desc = "Add cursors to cword" },
            {
                "<Leader>A",
                "<Cmd>MultipleCursorsAddMatchesV<CR>",
                mode = { "n", "x" },
                desc = "Add cursors to cword in previous area",
            },

            {
                "<Leader>d",
                "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
                mode = { "n", "x" },
                desc = "Add cursor and jump to next cword",
            },
            { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

            { "<Leader>l", "<Cmd>MultipleCursorsLock<CR>",          mode = { "n", "x" }, desc = "Lock virtual cursors" },
        },
    },
}
