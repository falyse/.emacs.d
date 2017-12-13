;(add-hook 'find-file-hook 'flymake-find-file-hook)

; Enable flycheck globally
(add-hook 'after-init-hook #'global-flycheck-mode)

; Turn off perlcritic
(setq-default flycheck-disabled-checkers '(perl-perlcritic))

; Color mode line based on flycheck status
;(require 'flycheck-color-mode-line)
;(eval-after-load "flycheck"
;  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))


(provide 'setup-flymake)
