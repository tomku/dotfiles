
(add-to-list 'load-path (concat repo-dir "lua-mode/"))
(require 'lua-mode)
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(provide 'tomku-lua)