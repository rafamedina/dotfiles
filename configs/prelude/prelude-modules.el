(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
   (package-initialize)
   (package-refresh-contents)
   (package-install 'use-package)
   (require 'use-package)))
(require 'use-package)

(require 'prelude-helm) ;; Interface for narrowing and search
(require 'prelude-helm-everywhere)

(require 'prelude-company)
(require 'prelude-key-chord) ;; Binds useful features to key combinations
(require 'prelude-evil)
(require 'prelude-clojure)

(require 'prelude-emacs-lisp)
(require 'prelude-js)
(require 'prelude-lisp)
(require 'prelude-lsp)
(require 'prelude-org) ;; Org-mode helps you keep TODO lists, notes and more
(require 'prelude-scheme)
(require 'prelude-shell)
(require 'prelude-xml)
(require 'prelude-yaml)
