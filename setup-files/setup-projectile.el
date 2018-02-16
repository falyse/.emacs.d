;; Time-stamp: <2018-01-10 09:58:06 cfricano>

;; Projectile
;; Source: https://github.com/bbatsov/projectile

(require 'projectile)

; use C-x p for projectile prefix instead of C-c p
(define-key projectile-mode-map projectile-keymap-prefix nil)
(define-key projectile-mode-map (kbd "C-x p") #'projectile-command-map)

; helm completion
(setq projectile-completion-system 'helm)

; when switching projects, bring up helm buffer list instead of default find file
(setq projectile-switch-project-action 'helm-projectile)
;(setq projectile-switch-project-action 'projectile-commander)

; customize mode line
;(eval-after-load "projectile"
;  '(setq projectile-mode-line
;         '(:eval (list " [Proj:"
;                       (propertize (projectile-project-name)
;                                   'face '(:foreground "green"))
;                       "]"))))
(eval-after-load "projectile"
  '(setq projectile-mode-line
         '(:eval (list " [ "
                       (projectile-project-name)
                       " ]"))))

; enable everywhere
(projectile-global-mode)


; full helm integration
;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)


; enable caching to speed things up
(setq projectile-enable-caching t)


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


; custom project name can be added by putting this code in .dir-locals.el file in project root
;((nil . ((projectile-project-name . "my-custom-project-name"))))
; the following code automatically enables loading of any string lisp in that file
(put 'projectile-project-name 'safe-local-variable #'stringp)

(setq setup-projectile-loaded t)
(provide 'setup-projectile)
