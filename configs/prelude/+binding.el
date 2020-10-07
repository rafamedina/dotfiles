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
       (defun format-clojure ()
         "All clojure"
         (cider-format-buffer)
         (clojure-align))

       (local-set-key (kbd "C-c = a") 'format-clojure)
       (local-set-key (kbd "C-c = b") 'cider-format-buffer)
       (local-set-key (kbd "C-c = d") 'cider-format-defun)
       (local-set-key (kbd "C-c = r") 'cider-format-region)
       (general-def 'normal 'override
         "C-c C-o" 'cider-repl-clear-buffer)
       (general-def 'normal 'override
         "M-." 'cider-find-var)
       (general-def 'normal 'override
         "g d" 'cider-find-var)
       (general-def 'normal 'override
         "g o" 'cider-pop-back)
       (key-chord-define-global "gt" 'cider-find-var)))
(local-set-key (kbd "C-c C-b") 'cider-repl-clear-buffer)

(add-hook 'cider-test-report-mode-hook
  '(lambda ()
       (general-def 'normal 'override
         "q" 'cider-popup-buffer-quit-function)))

(add-hook 'cider-popup-buffer-mode-hook
  '(lambda ()
       (local-set-key (kbd "q") 'cider-quit)))

(progn
  (define-prefix-command 'w-key-map)
  (define-key w-key-map (kbd "-") 'split-window-below)
  (define-key w-key-map (kbd "/") 'split-window-right))
(global-set-key (kbd "<s-return> w") w-key-map)

(progn
  (define-prefix-command 's-key-map)
  (define-key s-key-map (kbd "b") 'helm-ag-buffers)
  (define-key s-key-map (kbd "f") 'helm-file-do-git-grep))
(global-set-key (kbd "<s-return> s") s-key-map)

(progn
  (define-prefix-command 'f-key-map)
  (define-key f-key-map (kbd "c") 'file-copy)
  (define-key f-key-map (kbd "r") 'crux-rename-buffer-and-file)
  (define-key f-key-map (kbd "d") 'crux-delete-file-and-buffer))
(global-set-key (kbd "<s-return> f") f-key-map)

(global-set-key (kbd "s-*") 'helm-projectile-ag)
(global-set-key (kbd "C-;") 'iedit-mode)

;; Make <escape> quit as much as possible - From SPACEMACS
(define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-ns-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-completion-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-must-match-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-isearch-map (kbd "<escape>") 'keyboard-escape-quit)

;; MAGIT
(define-key prelude-mode-map (kbd "s-m d b") 'magit-diff-buffer-file)
(define-key prelude-mode-map (kbd "s-m d s") 'magit-diff-buffer-staged)
(define-key prelude-mode-map (kbd "s-m d u") 'magit-diff-buffer-unstaged)
