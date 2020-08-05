

(use-package underwater-theme
             :ensure t)
(use-package ace-window
             :ensure t)

(setq default-frame-alist '((font . "Monaco-13")))
(setq prelude-theme 'underwater)

(let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu)))

(add-hook 'clojure-mode-hook
    '(lambda ()
       (local-set-key (kbd "C-c = b") 'cider-format-buffer)
       (local-set-key (kbd "C-c = d") 'cider-format-defun)
       (local-set-key (kbd "C-c = r") 'cider-format-region)))

(global-set-key (kbd "C-c -") 'split-window-below)
(global-set-key (kbd "C-c /") 'split-window-right)

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
