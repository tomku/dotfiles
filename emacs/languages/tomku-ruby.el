(defun tomku-ruby-init ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil))))

(require 'rvm)
;;(rvm-use-default)

(add-to-list 'load-path (concat repo-dir "rhtml/"))
;(require 'rhtml-mode)
;(autoload 'rhtml-mode "rhtml-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.html\.erb$" . rhtml-mode))

;(add-to-list 'load-path (concat repo-dir "jump/"))
(require 'jump)

;(add-to-list 'load-path (concat repo-dir "rinari/"))
;(add-to-list 'load-path (concat repo-dir "rinari/util"))



(require 'ruby-mode)
(tomku-ruby-init)
(require 'inf-ruby)
(require 'ruby-compilation)

(require 'rinari)

(provide 'tomku-ruby)
