;; Time-stamp: <2014-10-24 12:27:13 cfricano>

;; Yet Another Folding, Folding code blocks based on indentation.
;; Source: https://github.com/zenozeng/yafolding.el

(require 'yafolding)

(add-hook 'prog-mode-hook 'yafolding-mode)
(setq yafolding-ellipsis-content ">>>folded")

(provide 'setup-yafolding)

;; C-Enter   <- Fold the current block; cursor has to be on the top-most line of the block
;; C-S-Enter <- Toggle folding all blocks
