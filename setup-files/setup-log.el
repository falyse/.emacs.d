;; Time-stamp: <2018-02-16 10:55:41 cfricano>

;; log4j-mode
(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))

(setq log4j-match-fatal-regexp "\\<\\(FATAL\\|\\\\*F\\)\\>")
(setq log4j-match-error-regexp "\\<\\(ERROR\\|SEVERE\\|\\\\*E\\)\\>")
(setq log4j-match-warn-regexp "\\<\\(WARN\\(?:ING\\)?\\|\\\\*W\\)\\>")
(setq log4j-match-info-regexp "\\<\\(INFO\\|\\\\*I\\)\\>")

(setq setup-log-loaded t)
(provide 'setup-log)
