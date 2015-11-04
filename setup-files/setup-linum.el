;; Time-stamp: <2014-12-03 08:33:43 cfricano>

;; Linum

;; Enable the line number column on the left
(global-linum-mode 1)
(setq linum-format "%4d ") ; right aligned, 4 char wide line num col
;; disable linum for selected modes
;; (specified in `linum-disabled`modes-list` in linum-off.el)
;; (require 'linum-off)


(setq setup-linum-loaded t)
(provide 'setup-linum)
