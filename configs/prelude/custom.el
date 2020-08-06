
(prelude-require-packages '(underwater-theme 
                            winum
                            clj-refactor
                            flycheck-clj-kondo))

(setq default-frame-alist '((font . "Monaco-13")))
(load-theme 'underwater t)

(let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu)))

(setq ns-command-modifier 'super)
(setq ns-right-command-modifier ns-command-modifier)

(setq winum-keymap
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "C-`") 'winum-select-window-by-number)
      (define-key map (kbd "C-²") 'winum-select-window-by-number)
      (define-key map (kbd "s-0") 'winum-select-window-0-or-10)
      (define-key map (kbd "s-1") 'winum-select-window-1)
      (define-key map (kbd "s-2") 'winum-select-window-2)
      (define-key map (kbd "s-3") 'winum-select-window-3)
      (define-key map (kbd "s-4") 'winum-select-window-4)
      (define-key map (kbd "s-5") 'winum-select-window-5)
      (define-key map (kbd "s-6") 'winum-select-window-6)
      (define-key map (kbd "s-7") 'winum-select-window-7)
      (define-key map (kbd "s-8") 'winum-select-window-8)
      map))

(add-hook 'clojure-mode-hook
    '(lambda ()
       (local-set-key (kbd "C-c = b") 'cider-format-buffer)
       (local-set-key (kbd "C-c = d") 'cider-format-defun)
       (local-set-key (kbd "C-c = r") 'cider-format-region)))

(progn
  (define-prefix-command 'w-key-map)
  (define-key w-key-map (kbd "-") 'split-window-below)
  (define-key w-key-map (kbd "/") 'split-window-right))
(global-set-key (kbd "<s-return> w") w-key-map)

(progn
  (define-prefix-command 'f-key-map)
  (define-key f-key-map (kbd "b") 'helm-ag-buffers)
  (define-key f-key-map (kbd "f") 'helm-file-do-grep))
(global-set-key (kbd "<s-return> f") f-key-map)

(global-set-key (kbd "s-*") 'helm-projectile-ag)

(setq helm-ag-insert-at-point 'symbol)
(winum-mode)

(defun my-clojure-mode-hook ()
   (require 'flycheck-clj-kondo)
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (clojure-mode markdown-mode exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number move-text magit projectile imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring beacon anzu ace-window)))
 '(safe-local-variable-values (quote ((flycheck-disabled-checkers emacs-lisp-checkdoc)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
