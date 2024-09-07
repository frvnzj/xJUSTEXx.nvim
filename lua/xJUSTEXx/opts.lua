local M = {}

M.default_content = {
  project_dirs = {
    vim.fn.expand('$HOME') .. '/Documents/Articles',
    vim.fn.expand('$HOME') .. '/Documents/Research',
  },
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

function M.set_file_justfile(project_name)
  return string.format(M.default_content.justfile_content, project_name)
end

return M
