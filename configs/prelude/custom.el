;; =====================
;; => Custom packages
;; =====================
(prelude-require-packages '(underwater-theme
                            winum
                            clj-refactor
                            flycheck-clj-kondo
                            iedit
                            expand-region
                            minions
                            lispy
                            moody
                            rainbow-delimiters
                            highlight-parentheses
                            rainbow-mode
                            general
                            lispyville
                            dracula-theme
                            ))

;; =====================
;; => Stylist
;; =====================
(setq prelude-theme nil)
(set-face-attribute 'default nil
   :family "Monaco"
   :height 130
   :weight 'normal
   :width 'normal)
(load-theme 'dracula t)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; =====================
;; => Load external files
;; =====================
(let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu)))
(load "~/.emacs.d/personal/+binding.el")

;; =====================
;; => Settings
;; =====================
(setq x-select-enable-clipboard t
      helm-ag-insert-at-point 'symbol
      x-underline-at-descent-line t
      projectile-project-search-path '("~/dev/")
      lispyville-barf-stay-with-closing t
      highlight-parentheses t
      auto-revert-interval 1)           ; Refresh buffers fast

(setq hl-paren-background-colors '("blue"))

(dolist (mode
   '(column-number-mode     ; Show column number in mode line
      delete-selection-mode ; Replace selected text
      show-paren-mode       ; Highlight matching parentheses
      winner-mode))         ; Allow undo/redo on window operations
   (funcall mode 1))

 (lispyville-set-key-theme '(
                            additional
                            additional-insert
                            (additional-movement normal visual motion)
                            (additional-wrap insert normal)
                            arrows
                            (commentary visual normal)
                            text-objects
                            prettify
                            c-w
                            (operators normal)
                            (atom-motions t)
                            (escape insert emacs)
                             slurp/barf-cp))
(lispy-set-key-theme '(lispy c-digits))

(minions-mode 1)
(moody-replace-mode-line-buffer-identification)
(moody-replace-vc-mode)
(global-auto-revert-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

(winum-mode)

;; line numbres
(setq-default display-line-numbers 'visual
              display-line-numbers-widen t
              ;; this is the default
              display-line-numbers-current-absolute t)

(defun noct:relative ()
  (setq-local display-line-numbers 'visual))

(defun noct:absolute ()
  (setq-local display-line-numbers t))

(add-hook 'evil-insert-state-entry-hook #'noct:absolute)
(add-hook 'evil-insert-state-exit-hook #'noct:relative)

;; example of customizing colors
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; =====================
;; => Hooks
;; =====================
(defun my-clojure-mode-hook ()
    (require 'flycheck-clj-kondo)
    (require 'highlight-parentheses)
    (lispy-mode 1)
    (clj-refactor-mode t)
    (highlight-parentheses-mode t)
    (rainbow-delimiters-mode t)
    (yas-minor-mode t) ; for adding require/use/import statements
    (cljr-add-keybindings-with-prefix "C-c C-m"))
(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook #'rainbow-mode)

(dolist (hook '(clojure-mode-hook cider-repl-mode-hook))
  (add-hook hook 'lispyville-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode geiser lsp-ui company-lsp json-mode js2-mode rainbow-mode elisp-slime-nav evil-numbers evil-visualstar evil-surround evil cider clojure-mode rainbow-delimiters key-chord company helm-ag helm-descbinds helm-projectile helm exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number move-text magit projectile imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring beacon anzu ace-window))))
