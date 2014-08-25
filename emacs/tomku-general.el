(setq message-log-max 5000)

(defun tomku-init-yasnippet ()
  ;; This is a bit of a hack, there's no good way to keep the built-in
  ;; snippet directory on the list without toggling yasnippet twice.
  (yas-global-mode nil)
  (add-to-list 'yas-snippet-dirs
               (concat shared-config-dir "snippets/"))
  (yas-global-mode 1))

(eval-after-load "yasnippet"
  (tomku-init-yasnippet))

(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))


(require 'ido)
(ido-mode)
(ido-everywhere 1)
(setq ido-max-directory-size 100000)

(defun tomku-smex-init ()
  (smex-initialize)
  (smex-auto-update 60)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c M-x") 'smex-update-and-run)
  (global-set-key (kbd "C-c C-x M-x") 'execute-extended-command))

(eval-after-load "smex"
  '(tomku-smex-init))

(require 'tramp)
(if nix-platform
    (setq tramp-default-method "sftp")
  (setq tramp-default-method "plink"))

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

(require 'webjump)

(setq webjump-sites
      (append '(("Reddit Search" .
                 [simple-query "www.reddit.com" "http://www.reddit.com/search?q=" ""])
                ("Google Image Search" .
                 [simple-query "images.google.com" "images.google.com/images?hl=en&q=" ""])
                ("Flickr Search" .
                 [simple-query "www.flickr.com" "flickr.com/search/?q=" ""])
                ("Java API" .
                 [simple-query "www.google.com" "http://www.google.com/search?hl=en&as_sitesearch=http://java.sun.com/javase/6/docs/api/&q=" ""])
                ("DuckDuckGo" .
                 [simple-query "www.duckduckgo.com" "https://www.duckduckgo.com/?q=" ""]))
              webjump-sample-sites))

(global-set-key [f2] 'webjump)

(defun webjump-ddg ()
  (interactive)
  (funcall browse-url-browser-function
           (webjump-url-fix
            (webjump-builtin
             [simple-query "www.duckduckgo.com" "https://www.duckduckgo.com/?q=" ""] "DuckDuckGo"))))

(global-set-key [S-f2] 'webjump-ddg)

(require 'flyspell)

(require 'thingatpt)
(require 'imenu)

(defun view-url ()
  "Open a new buffer containing the contents of URL."
  (interactive)
  (let* ((default (thing-at-point-url-at-point))
         (url (read-from-minibuffer "URL: " default)))
    (switch-to-buffer (url-retrieve-synchronously url))
    (rename-buffer url t)
    ;; TODO: switch to nxml/nxhtml mode
    (cond ((search-forward "<?xml" nil t) (xml-mode))
          ((search-forward "<html" nil t) (html-mode)))))

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
                              
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
                              
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
                             
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

;;; These belong in coding-hook:

;; We have a number of turn-on-* functions since it's advised that lambda
;; functions not go in hooks. Repeatedly evaling an add-to-list with a
;; hook value will repeatedly add it since there's no way to ensure
;; that a lambda doesn't already exist in the list.

(defun local-column-number-mode ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t))

(defun local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (auto-fill-mode t))

(defun turn-on-hl-line-mode ()
  (if window-system (hl-line-mode t)))

(defun turn-on-save-place-mode ()
  (setq save-place t))

(defun turn-on-whitespace ()
  (whitespace-mode t))

(defun run-coding-hook ()
  "Enable things that are convenient across all coding buffers."
  (run-hooks 'coding-hook))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(add-hook 'coding-hook 'local-column-number-mode)
(add-hook 'coding-hook 'local-comment-auto-fill)
(add-hook 'coding-hook 'turn-on-hl-line-mode)

(defun sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(defun insert-date ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%c" (current-time))))

(defun unix-line-endings-please ()
  (set-buffer-file-coding-system 'unix))

(add-hook 'find-file-hook 'unix-line-endings-please)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-z") nil)

;(require 'autopair)
(eval-after-load "autopair"
  '(autopair-global-mode 1))

(defun disable-autopair ()
  "Turn off auto-pair mode for the current buffer."
  (setq autopair-dont-activate t))

(add-hook 'slime-repl-mode-hook 'disable-autopair)
(add-hook 'ansi-term-mode-hook 'disable-autopair)
(add-hook 'term-mode-hook 'disable-autopair)

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md(wn)?" . markdown-mode) auto-mode-alist))
(unless nix-platform
  (setq markdown-command "markdown_py"))

(require 'midnight)
(midnight-delay-set 'midnight-delay "12:01am")

(provide 'tomku-general)
