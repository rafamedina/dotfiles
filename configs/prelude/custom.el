;; =====================
;; => Custom packages 
;; =====================
(prelude-require-packages '(underwater-theme 
                            winum
                            clj-refactor
                            flycheck-clj-kondo
                            iedit
                            expand-region))
;; =====================
;; => Stylist 
;; =====================
(setq default-frame-alist '((font . "Monaco-13")))
(load-theme 'underwater t)

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
(setq x-select-enable-clipboard t)
(setq helm-ag-insert-at-point 'symbol)

(winum-mode)

;; =====================
;; => Hooks 
;; =====================
(defun my-clojure-mode-hook ()
   (require 'flycheck-clj-kondo)
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (iedit zop-to-char zenburn-theme yaml-mode winum which-key volatile-highlights use-package underwater-theme super-save smartrep smartparens rainbow-mode rainbow-delimiters operate-on-number move-text magit lsp-ui key-chord json-mode js2-mode imenu-anywhere hl-todo helm-projectile helm-descbinds helm-ag guru-mode gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck-clj-kondo expand-region exec-path-from-shell evil-visualstar evil-surround evil-numbers elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux company-lsp clj-refactor browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
