;; Time-stamp: <2017-12-13 20:51:54 cfricano>

;; Projectile
;; Source: https://github.com/bbatsov/projectile

(require 'projectile)

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


; perspective integration for workspace management
;(require 'persp-projectile)
;(persp-mode)


(setq setup-projectile-loaded t)
(provide 'setup-projectile)
