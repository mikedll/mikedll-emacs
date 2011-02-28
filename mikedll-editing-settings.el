;;
;; Mike De La Loza
;; email: mikedll@mikedll.com
;; web: mikedll.com
;;
;; These are settings (tab sizes, etc) that I prefer for when I edit code.
;;

;; Helpful for text editing
(setq column-number-mode t)
(global-font-lock-mode t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq hi-lock-mode t)
(setq transient-mark-mode t)
(setq make-backup-files nil)

;; Helpful for Programming
(setq compilation-scroll-output 1)
(custom-set-variables
 '(case-fold-search t)
 '(standard-indent 2))
(global-set-key "\C-xg" 'goto-line)
(global-set-key "\C-x'" 'recompile)
(linum-mode)


;; Lisp
(global-set-key (kbd "C-S-e") 'eval-region)

