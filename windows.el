

(defun setup-win32-bash()
  "Bunch of configs I barely or don't understand"
  (add-hook 'comint-output-filter-functions
	    'shell-strip-ctrl-m nil t)
  (add-hook 'comint-output-filter-functions
	    'comint-watch-for-password-prompt nil t)

  (setq shell-file-name "bash.exe")
  (setq explicit-shell-file-name "bash.exe")

  ;; Notes to self: Learn wtf is going on
  ;; Without this, doesn't load my .bash_profile
  ;; -i *must* come last in this list. .bash_profile can't be
  ;; combined into the same string as --init-file.
  ;; type of explicit-bash.exe-args is a LIST, not a STRING

  (setq explicit-bash.exe-args '("--init-file" "/Users/mrmike/Documents/My Dropbox/common/.bash_profile" "-i"))

  ;; Without this, bash doesn't know where HOME is on windows.
  ;; However, this doesn't work on Windows 7 anyway...so bash probably won't work here.
  ;; (setenv "HOME" home-dir)

  ;; This is necessary, my .bash_profile will break the prompt in emacs
  (setenv "EMACS" "YES")
  )

(defun try-setup-win32-bash ()
  "Setup variables so that bash works on windows/cygwin"
  ;; Allow bash.exe to be invoked
  (setenv "PATH" (concat "C:/bin;" (getenv "PATH")))
  (setq exec-path (cons "C:/bin" exec-path))

  ;; For subprocesses invoked via the shell
  ;; (e.g., "shell -c command")
  ;; Use bash if its available
  
  (if (executable-find "bash.exe") (setup-win32-bash))
  )

(defun setup-scheme ()
  (setenv "PATH" (concat "C:/Program Files (x86)/MIT-GNU Scheme/bin;" (getenv "PATH")))
  (setq exec-path (cons "C:/Program Files (x86)/MIT-GNU Scheme/bin" exec-path)))

(defun setup-win()
  "Hook for all windows initialization"
  (try-setup-win32-bash)

  (if (equal (getenv "COMPUTERNAME") "MRMIKE-MACBOOK") 
      (setq work-dir (concat home-dir "/work"))
      )
  ;; Disable chime on windows...so annoying every time I press quit
  (setq visible-bell t)

  (setup-scheme)
  )

(if (is-win) (setup-win))
