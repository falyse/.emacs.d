;; Time-stamp: <2017-10-20 08:04:15 cfricano>

;; log4j-mode
(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))


(setq setup-log-loaded t)
(provide 'setup-log)
