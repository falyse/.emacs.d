;; Time-stamp: <2014-10-24 11:11:28 cfricano>

;; YASnippet

(require 'yasnippet)
;;(yas-global-mode 1)

(setq yas-prompt-functions '(yas-ido-prompt
                             yas-completing-prompt)
      yas-new-snippet-default "# -*- mode: snippet -*-
# name: $1
# key: ${2:${1:$(yas--key-from-desc yas-text)}}${3:
# binding: ${4:direct-keybinding}}${5:
# expand-env: ((yas-indent-line 'auto) (yas-also-auto-indent-first-line t) (yas-wrap-around-region t))}
# --
$0"
      )


(yas-reload-all)
(dolist (hook '(verilog-mode-hook
                emacs-lisp-mode-hook))
  (add-hook hook 'yas-minor-mode))))

(setq setup-yasnippet-loaded t)
(provide 'setup-yasnippet)
