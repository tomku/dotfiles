(add-to-list 'load-path (concat repo-dir "slime/"))
(require 'slime)
(slime-setup '(slime-repl))

;;(setq inferior-lisp-program "sbcl")

;;(add-hook 'lisp-mode-hook 'run-coding-hook)
;;(add-hook 'lisp-mode-hook 'idle-highlight)

(font-lock-add-keywords 'lisp-mode
			'(("(\\|)" . 'esk-paren-face)))
(provide 'tomku-slime)