;; Time-stamp: <2013-12-02 17:07:31 kmodi>

;; header2

;; Add a file header whenever a new file is created in specific modes
(autoload 'auto-make-header "header2")
(add-hook 'verilog-mode-hook 'auto-make-header)

(setq setup-header2-loaded t)
(provide 'setup-header2)
