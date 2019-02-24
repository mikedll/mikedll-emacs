
(defun move-emacs-right()
  (interactive)
  (shell-command "emacsToRight.sh")
  )

(defun setup-linux()
  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
  (global-set-key (kbd "M-p 1") 'move-emacs-right)
  )

(if (is-linux) (setup-linux))


