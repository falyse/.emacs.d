;; Time-stamp: <2018-02-22 09:28:50 cfricano>

;; log4j-mode
(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))

(setq log4j-match-fatal-regexp "\\<\\(FATAL\\|\\\\*F\\)\\>")
(setq log4j-match-error-regexp "\\<\\(ERROR\\|SEVERE\\|\\\\*E\\)\\>")
(setq log4j-match-warn-regexp "\\<\\(WARN\\(?:ING\\)?\\|\\\\*W\\)\\>")
(setq log4j-match-info-regexp "\\<\\(INFO\\|\\\\*I\\|\\\\*N\\)\\>")
(setq log4j-match-debug-regexp "\\<\\(DEBUG\\|FINE\\(?:R\\|ST\\)?\\|STATUS\\|asdf\\)\\>")
      
(setq setup-log-loaded t)
(provide 'setup-log)
