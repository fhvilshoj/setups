(setq inhibit-startup-message t)

(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(load-file "~/.emacs.d/themes/idea-darkula-theme-20160416.1603.el")

(set-face-attribute 'default nil :height 170)

(setq-default TeX-master nil)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "M-p") 'duplicate-line)

(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

(setq-default c-basic-offset 4)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        "~/.emacs.d/plugins/yasnippet/yasmate/snippets" ;; the yasmate collection
        "~/.emacs.d/plugins/yasnippet/snippets"         ;; the default collection
        ))

(yas-global-mode 1)

(setq yas-prompt-functions '(yas-ido-prompt))

(global-set-key "\M-t" nil)
(global-set-key "\M-t\M-t" 'yas-insert-snippet)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (polymode magit typescript-mode php-mode nlinum markdown-mode json-mode graphviz-dot-mode gnuplot-mode gh-md expand-region editorconfig dropdown-list diff-hl context-coloring auto-complete auctex aes)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "C-h o") 'beginning-of-buffer)

(global-set-key (kbd "C-x g") 'magit-status)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(load "~/.emacs.d/lisp/aes.el")
(require 'aes)

(load "~/.emacs.d/lisp/unbound.el")
(require 'unbound)

(defun fh-align-whitespace (start end)
  "Align columns by whitespace"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)\\s-" 1 0 t))

(global-set-key (kbd "C-h u") 'fh-aligh-whitespace)

(defun fh-align-to-colon (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ":") 1 1 ))

(defun fh-align-to-ampersant (begin end)
  "Align region to ampersant (&) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "&") 1 1 ))

(defun fh-align-to-comma (begin end)
  "Align region to comma  signs"
  (interactive "r")
  (align-regexp begin end
                (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))


(defun fh-align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=") 1 1 ))

;; work with this
(defun fh-align-to-comma-before (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ",") 1 1 ))


(add-to-list 'auto-mode-alist '("\\.Rmd" . markdown-mode))
(setq markdown-enable-math t)
