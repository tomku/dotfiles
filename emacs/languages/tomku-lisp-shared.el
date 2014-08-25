(defun turn-on-paredit ()
  (paredit-mode 1))

(defun tomku-paredit-init ()
  (add-hook 'lisp-mode-hook 'turn-on-paredit)
  (add-hook 'clojure-mode-hook 'turn-on-paredit)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-paredit)
  (add-hook 'scheme-mode-hook 'turn-on-paredit)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-paredit))

(require 'paredit)
(tomku-paredit-init)

;(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
;(define-key lisp-mode-shared-map (kbd "C-c C-l") "lambda")
;(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
;(define-key lisp-mode-shared-map (kbd "C-\\") 'lisp-complete-symbol)
;(define-key lisp-mode-shared-map (kbd "C-c v") 'eval-buffer)

(defface esk-paren-face
  '((((class color) (background dark) (min-colors 257))
     (:foreground "grey50"))
    (((class color) (background light) (min-colors 257))
     (:foreground "grey55")))
  "Face used to dim parentheses."
  :group 'starter-kit-faces)

;(require 'tomku-slime)

(provide 'tomku-lisp-shared)
