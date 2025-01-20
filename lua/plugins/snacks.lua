return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		dashboard = {
			preset = {
				header = [[
     ...     ...           ..      .             ....                                  .....     .      ...     ..      ..     
  .=*8888n.."%888:      x88f` `..x88. .>     .x~X88888Hx.                            .d88888Neu. 'L   x*8888x.:*8888: -"888:   
 X    ?8888f '8888    :8888   xf`*8888%     H8X 888888888h.        ...     ..        F""""*8888888F  X   48888X `8888H  8888   
 88x. '8888X  8888>  :8888f .888  `"`      8888:`*888888888:    :~""888h.:^"888:    *      `"*88*"  X8x.  8888X  8888X  !888>  
'8888k 8888X  '"*8h. 88888' X8888. >"8x    88888:        `%8   8X   `8888X  8888>    -....    ue=:. X8888 X8888  88888   "*8%- 
 "8888 X888X .xH8    88888  ?88888< 888> . `88888          ?> X888n. 8888X  ?888>           :88N  ` '*888!X8888> X8888  xH8>   
   `8" X888!:888X    88888   "88888 "8%  `. ?888%           X '88888 8888X   ?**h.          9888L     `?8 `8888  X888X X888>   
  =~`  X888 X888X    88888 '  `8888>       ~*??.            >   `*88 8888~ x88x.     uzu.   `8888L    -^  '888"  X888  8888>   
   :h. X8*` !888X    `8888> %  X88!       .x88888h.        <   ..<"  88*`  88888X  ,""888i   ?8888     dx '88~x. !88~  8888>   
  X888xX"   '8888..:  `888X  `~""`   :   :"""8888888x..  .x       ..XC.    `*8888k 4  9888L   %888>  .8888Xf.888x:!    X888X.: 
:~`888f     '*888*"     "88k.      .~    `    `*888888888"      :888888H.    `%88> '  '8888   '88%  :""888":~"888"     `888*"  
    ""        `"`         `""*==~~`              ""***""       <  `"888888:    X"       "*8Nu.z*"       "~'    "~        ""    
                                                                     %888888x.-`                                               
                                                                       ""**""                                                  
                                                                                                                               
      ]],
			},
		},
		-- bigfile = {
		-- 	enabled = true,
		-- 	size = 10 * 1024 * 1024, -- 1.5MB
		-- },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
