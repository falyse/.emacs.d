;; Time-stamp: <2014-07-14 19:52:45 cfricano>

;; Guide Key
;; Source: https://github.com/kbkbkbkb1/guide-key

(require 'guide-key)

(setq guide-key/guide-key-sequence '("C-x r" ;; rectangle, registers
                                     "C-x 4" ;; other window
                                     "C-c p" ;; projectile
                                     "C-c v" ;; workgroups
                                     "C-x m" ;; my custom map: modi-map
                                     "C-x"
                                     "C-c"
                                     )
      guide-key/highlight-command-regexp "rectangle"
      ;; guide-key can highlight commands which match a specified regular expression.
      ;; Key bindings following "C-x r" are rectangle family and register family.
      ;; Below setting highlights only rectangle family commands.
      guide-key/idle-delay 2 ;; delay before the guide shows up, default is 1 second
      guide-key/popup-window-position 'bottom ;; show guide key popup at bottom
      )
(guide-key-mode 1)  ; Enable guide-key-mode

(provide 'setup-guide-key)
