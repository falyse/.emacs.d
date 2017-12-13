;; Time-stamp: <2017-12-13 16:23:02 cfricano>

;; Projectile
;; Source: https://github.com/bbatsov/projectile

(require 'projectile)

; helm completion
(setq projectile-completion-system 'helm)

; customize mode line
(eval-after-load "projectile"
  '(setq projectile-mode-line
         '(:eval (list " [Proj:"
                       (propertize (projectile-project-name)
                                   'face '(:foreground "green"))
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
