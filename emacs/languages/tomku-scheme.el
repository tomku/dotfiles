(require 'tomku-lisp-shared)

(require 'quack)

(add-hook 'scheme-mode-hook 'run-coding-hook)
(add-hook 'scheme-mode-hook 'idle-highlight)
(font-lock-add-keywords 'scheme-mode
			'(("(\\|)" . 'esk-paren-face)))

(provide 'tomku-scheme)