;; Time-stamp: <2013-12-02 17:07:08 kmodi>

;; Hspice, Spice

(autoload 'spice-mode "spice-mode" "Spice/Layla Editing Mode" t)
(setq auto-mode-alist
      (append (list (cons "\\.sp$" 'spice-mode)
                    (cons "\\.cir$" 'spice-mode)
                    (cons "\\.ckt$" 'spice-mode)
                    (cons "\\.mod$" 'spice-mode)
                    (cons "\\.cdl$" 'spice-mode)
                    (cons "\\.chi$" 'spice-mode) ;eldo outpt
                    (cons "\\.inp$" 'spice-mode))
              auto-mode-alist))

(provide 'setup-hspice)
