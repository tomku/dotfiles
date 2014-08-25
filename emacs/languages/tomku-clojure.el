(require 'tomku-lisp-shared)

(require 'clojure-mode)
(require 'clojure-test-mode)

;;(add-hook 'clojure-mode-hook 'run-coding-hook)
;;(add-hook 'clojure-mode-hook 'idle-highlight)

(font-lock-add-keywords 'clojure-mode
                        '(("(\\|)" . 'esk-paren-face)))


;(setq slime-net-coding-system 'utf-8-unix)


;; esk-clojure-trace-face
;;   '((((class color) (background dark))
;;      (:foreground "grey50"))
;;     (((class color) (background light))
;;      (:foreground "grey55")))
;;   "Face used to dim parentheses."
;;   :group 'starter-kit-faces)

;;(setq esk-clojure-trace-face 'esk-clojure-trace-face)

;; (defun sldb-font-lock ()
;;   (font-lock-add-keywords nil
;;                           '(("[0-9]+: \\(clojure\.\\(core\\|lang\\).*\\)"
;;                              1 esk-clojure-trace-face)
;;                             ("[0-9]+: \\(java.*\\)"
;;                              1 esk-clojure-trace-face)
;;                             ("[0-9]+: \\(swank.*\\)"
;;                              1 esk-clojure-trace-face)
;;                             ("\\[\\([A-Z]+\\)\\]"
;;                              1 font-lock-function-name-face))))

;; (add-hook 'sldb-mode-hook 'sldb-font-lock)

(provide 'tomku-clojure)
