;; Workgroups2

(require 'workgroups2)

;; if you start Emacs as "emacs --daemon" - turn off autoloading of workgroups:
(setq wg-use-default-session-file nil)

;; Change prefix key (before activating WG)
(setq wg-prefix-key (kbd "C-c v"))

;; Change workgroups session file
(setq wg-default-session-file "~/.emacs.tmp/.emacs_workgroups")

;; Set your own keyboard shortcuts to reload/save/switch WG:
;;(global-set-key (kbd "<pause>")     'wg-reload-session)
;;(global-set-key (kbd "C-S-<pause>") 'wg-save-session)
(global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
(global-set-key (kbd "s-x")         'wg-switch-to-previous-workgroup)
(global-set-key (kbd "<s-left>")    'wg-switch-to-workgroup-left)
(global-set-key (kbd "<s-right>")   'wg-switch-to-workgroup-right)
(global-set-key (kbd "s-b")         'wg-switch-to-buffer)
(global-set-key (kbd "C-x x")       'wg-switch-to-buffer)

;; Restore all associated buffers
(setq wg-restore-associated-buffers t)

;; Turn on workgroups mode
(workgroups-mode 1)

(setq setup-workgroups-loaded t)
(provide 'setup-workgroups)
