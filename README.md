# xJUSTEXx

![xJAVx](assets/xJAVx.png)

Hice este plugin con la idea de facilitar la creación de mis ensayos con LaTeX a través de Neovim. Mezclo la creación de proyectos (una estructura básica de workspace e inicialización de repositorio git) con el fácil acceso a los comandos de TeXlive para compilar a través Just y justfile.

## Tabla de Contenidos

- [Instalación](#instalación)
- [Configuración](#configuración)
- [Uso](#uso)
- [Comandos](#comandos)
- [Opciones de Configuración](#opciones-de-configuración)
- [Contribuciones](#contribuciones)

## Instalación

Para instalar puedes usar el plugin manager que prefieras. El siguiente ejemplo es con [lazy.nvim](https://github.com/folke/lazy.nvim) y depende de [fidget.nvim](https://github.com/j-hui/fidget.nvim) para conocer el status de la compilación.

```lua
{
  "frvnzj/xJUSTEXx.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
  },
  config = function()
    require("xJUSTEXx").setup()
  end,
}
```

## Configuración

La configuración tiene tres opciones (directorio de los proyectos, plantilla o contenido con el que se iniciará el tex main y el contenido del .justfile que declara los comandos a usar). Las opciones por default son las siguientes:

```lua
{
    project_dir = vim.fn.expand('$HOME') .. '/Documents/Articles',
    tex_content = [[
\documentclass{article}

\begin{document}

\end{document}
]],

    justfile_content = [[
main_file := "%s.tex"

lualatex:
  @latexmk -lualatex -interaction=nonstopmode -synctex=-1 {{main_file}}

pdflatex:
  @latexmk -pdf -interaction=nonstopmode -synctex=-1 {{main_file}}

pdfxe:
  @latexmk -pdfxe -interaction=nonstopmode -synctex=-1 {{main_file}}

clean:
  @texclear {{main_file}}
]],
}
```

## Uso

![ProJustex](assets/ProJustex.png)

xJUSTEXx ofrece básicamente dos funciones: crear proyecto (carpeta root, repositorio git y main file) y compilar utilizando optativamente LuaLaTeX, pdfLaTeX o XeLaTeX con la ayuda/dependencia de [Just](https://github.com/casey/just).

### Comandos

Para iniciar un proyecto nuevo de LaTeX usa el comando:

```lua
:ProJustex

-- o

require("xJUSTEXx").xTEXx()
```

Para compilar el proyecto utiliza el comando:

```lua
:Justex lualatex -- por ejemplo

-- o

require("xJUSTEXx").xJUSTEXx("lualatex")
```

## Opciones de Configuración

![Justex](assets/Justex.png)

La configuración no se limita a las 3 opciones disponibles a modificar del plugin. Por ejemplo, la configuración de uso personal para iniciar proyectos de ensayo:

```lua
require("xJUSTEXx").setup({
    tex_content = [[
\documentclass[doc,12pt]{apa7}

% Font option: Arial[Arial], Carlito[Carlito], Droid Serif[Droid],
% GFS Didot [GFSDidot](default), IM FELL English[IMFELLEnglish], Kerkis[Kerkis], Times New Roman[TNR].
\usepackage{xJAVx-apa7} % This is my package

% \hypersetup{
% 	pdftitle={<++>},
% 	pdfkeywords={<++>}
% }


\begin{document}

\authorsnames{<++>}
\authorsaffiliations{<++>}
\title{<++>}
\shorttitle{<++>}

% \abstract{<++>}
% \keywords{<++>}

% \authornote{<++>}

\maketitle

% \fontsize{12pt}{14pt}\selectfont\doublespacing{}
\fontsize{12pt}{14pt}\selectfont\onehalfspacing{}

<++>

\end{document}
]]
})
```


![xJUSTEXx](assets/xJUSTEXx.png)

También es recomendable el uso de [which-key](https://github.com/folke/which-key.nvim) o nvim_set_keymap() en `ftplugin/tex.lua` y `ftplugin/plaintex.lua`, por ejemplo:

```lua
local wk = require("which-key")


wk.add {
  { "<leader>wa", "<cmd>Justex lualatex<cr>", desc = "xJAVx LuaLaTeX", icon = { icon = "", color = "azure" }, },
  { "<leader>wb", "<cmd>Justex pdflatex<cr>", desc = "xJAVx LaTeX", icon = { icon = "", color = "azure" }, },
  { "<leader>wc", "<cmd>Justex pdfxe<cr>", desc = "xJAVx XeLaTeX", icon = { icon = "", color = "azure" }, },
  { "<leader>wd", "<cmd>Justex clean<cr>", desc = "xJAVx CleanAuxFiles", icon = { icon = "", color = "azure" }, },
}

-- Estos keymaps permiten ir rápidamente a los sitios que quiero modificar,
-- por ejemplo, en \authorsnames{<++>} me lleva dentro de { } borrando <++>
-- permitiéndome ingresar el nombre \authorsnames{xJAVx}
vim.keymap.set("n", ",,", "<cmd>keepp /<++><cr>ca<", { noremap = true, silent = true })
vim.keymap.set("i", ",,", "<esc>0<cmd>keepp /<++><cr>ca<", { noremap = true, silent = true })
```


## Contribuciones

Si deseas contribuir mejorando el plugin o reportar errores, quedo atento.

### License MIT
