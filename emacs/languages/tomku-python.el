;;(add-to-list 'load-path (concat repo-dir "python-mode/"))
;;(require 'python-mode)

;;(add-to-list 'load-path (concat repo-dir "python-gallina/"))
(add-to-list 'load-path (concat repo-dir "python-pep8/"))

(require 'python)
(require 'python-pep8)

(defun tomku-python-init ()
 (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
 (add-to-list 'interpreter-mode-alist '("python" . python-mode))
 (autoload 'python-mode "python-mode" "Python editing mode." t)
 
 (add-to-list 'auto-mode-alist '("\\(^\\|/\\)SCons" . python-mode))
 (define-key python-mode-map (kbd "RET") 'newline-and-indent)
 (add-hook 'inferior-python-mode-hook 'tomku-inferior-python-mode-hook)
 (add-hook 'python-mode-hook 'tomku-python-mode-hook))

(defun tomku-python-mode-hook ()
  (eldoc-mode t))

(defun tomku-inferior-python-mode-hook ()
  (set (make-local-variable 'comint-prompt-read-only) t))

(when nix-platform
 (setq
  python-shell-interpreter "ipython"
  python-shell-interpreter-args "-colors NoColor"
  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
  python-shell-completion-setup-code ""
  python-shell-completion-string-code "';'.join(__IP.complete('''%s'''))\n"))

;(when nix-platform
;  (require 'ipython)
;  (setq py-python-command "ipython"))

(tomku-python-init)

(require 'virtualenv)
(provide 'tomku-python)
