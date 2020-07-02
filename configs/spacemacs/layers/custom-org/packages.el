(defconst custom-org-packages 
          '(
            auth-source-pass
            org-gcal
            calfw
            alert
            org-fancy-priorities))

(defun custom-org/init-auth-source-pass ()
  (use-package auth-source-pass
    :init
    (auth-source-pass-enable)))

(defun custom-org/init-org-gcal()
  (use-package org-gcal
    :commands org-gcal-fetch
    :config
    ;; XXX: auth-source-pass is emacs 26 only
    (use-package auth-source-pass
      :config
      (auth-source-pass-enable))
    (setq org-gcal-client-id ""
          org-gcal-client-secret ""
          org-gcal-file-alist
          '(("rafael.medina@nubank.com.br" .  "~/.orgcalendar/gcal-main.org")
            )))
    (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
    (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))
  )

(defun custom-org/init-calfw ()
 (use-package calfw
 :ensure ;TODO:
 :config
 (require 'calfw)
 (require 'calfw-org)
 (setq cfw:org-overwrite-default-keybinding t)
 (require 'calfw-ical)))

(defun custom-org/init-alert ()
  "Initialize alert"
  (use-package alert)
  )

(defun custom-org/init-org-fancy-priorities ()
    (use-package org-fancy-priorities
    :ensure t
    :hook
    (org-mode . org-fancy-priorities-mode)
    :config
    (setq org-fancy-priorities-list '("⚡ " "⬆" "⬇" "☕"))))
