

(defun osx-launch-finder()
  "Launch finder in current location."
  (interactive)
  (shell-command "open .")
  )


(defun capture-command-key()
  "Copied and pasted from windows config. turns out the be the same on mac osx."
  (setq w32-pass-lwindow-to-system t
	w32-pass-rwindow-to-system t 
	w32-pass-apps-to-system t
	w32-lwindow-modifier 'super ;; Left Windows key 
	w32-rwindow-modifier 'super ;; Right Windows key 
	w32-apps-modifier 'hyper) ;; Menu key
  )

(defun setup-osx ()
  "Setup variables so that bash works on windows/cygwin"

  ;; For some reason, this is required to get the toolbar to go away on OS X.
  (tool-bar-mode)

  ;; Why doesn't OS X put /usr/local/bin in the exec path on its own? Only The Shadow knows...
  (setq exec-path (cons "/usr/local/bin" exec-path))
  (setq exec-path (cons "/usr/local/mysql/bin" exec-path))

  ;; Now setup bash.
  ;; Note that this stuff works with the "shell" command
  ;; but not the "term" command.

  ;; Dunno why we need this.
  (setenv "PATH" (concat "/usr/local/bin" ":" (getenv "PATH")))


  (add-hook 'comint-output-filter-functions
	    'shell-strip-ctrl-m nil t)
  (add-hook 'comint-output-filter-functions
	    'comint-watch-for-password-prompt nil t)

  ;; For subprocesses invoked via the shell
  ;; (e.g., "shell -c command")
  (setq shell-file-name "bash")
  (setq explicit-shell-file-name "bash")
	
  ;; Notes to self: Learn wtf is going on
  ;; Without this, doesn't load my .bash_profile
  ;; -i *must* come last in this list. .bash_profile can't be
  ;; combined into the same string as --init-file.
  ;; type of explicit-bash.exe-args is a LIST, not a STRING
  (setq explicit-bash-args '("--init-file" "/Users/michaelrivera/Dropbox/common/.bash_profile" "-i"))

  ;; This is necessary, my .bash_profile will break the prompt in emacs
  (setenv "EMACS" "YES")

  ;; setting vislbe bell to true doesn't really help.
  ;; http://emacsblog.org/2007/02/06/quick-tip-visible-bell/
  (setq ring-bell-function (lambda () (message "*beep*")))

  (capture-command-key)
  (global-set-key (kbd "s-w") 'osx-launch-finder)  
  )

(if (is-osx) (setup-osx))
