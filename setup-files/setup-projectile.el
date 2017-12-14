;; Time-stamp: <2017-12-14 09:37:27 cfricano>

;; Projectile
;; Source: https://github.com/bbatsov/projectile

(require 'projectile)

; use C-x p for prefix instead of C-c p
(setq projectile-keymap-prefix (kbd "C-x p"))

; helm completion
(setq projectile-completion-system 'helm)

; when switching projects, bring up helm buffer list instead of default find file
(setq projectile-switch-project-action 'helm-projectile)

; customize mode line
;(eval-after-load "projectile"
;  '(setq projectile-mode-line
;         '(:eval (list " [Proj:"
;                       (propertize (projectile-project-name)
;                                   'face '(:foreground "green"))
;                       "]"))))
(eval-after-load "projectile"
  '(setq projectile-mode-line
         '(:eval (list " ["
                       (projectile-project-name)
                       "]"))))

; enable everywhere
(projectile-global-mode)


; full helm integration
;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)


; term integration via term-projectile
; override this function to use ansi-term instead of term
;(require 'term-projectile)
;(defun term-manager-default-build-term (directory-symbol)
;     (let* ((directory (symbol-name directory-symbol))
;            (default-directory directory)
;            (program (getenv "SHELL"))
;            (buffer (get-buffer
;                     ;; We need to use a name that is guaranteed to be
;                     ;; unique so that term-ansi-make-term always makes a
;                     ;; new term.
;                     ;cef use ansi-term instead of term to enable C-x prefix
;                     ;cef (term-ansi-make-term "new term temp name" program))))
;                     (shell))))
;       ;cef (with-current-buffer buffer
;       ;cef   (term-mode)
;       ;cef   (term-char-mode))
;       buffer))

; perspective integration for workspace management
;(require 'persp-projectile)
;(persp-mode)


(setq setup-projectile-loaded t)
(provide 'setup-projectile)
