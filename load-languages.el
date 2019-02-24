


;; Yas Snippets. Supports all languages.
(add-to-list 'load-path (concat emacs-dir "/yasnippet-0.6.1c"))
(require 'yasnippet)
(defun load-snippet-subdir-non-recursive (directory)
  (yas/load-directory-1 (concat emacs-dir "/yasnippet-0.6.1c/snippets/" directory) nil 'no-hierarchy-parents)
  )
(load-snippet-subdir-non-recursive "text-mode")
(yas/global-mode 1)

;; Only define the root-directory if you want to enable a world of load pain.
;; yas/snippets sucks.
;; (setq yas/root-directory (concat emacs-dir "/yasnippet-0.6.1c/snippets"))


;; Objective C
;; Bret Hartley's (cp?) code for identifying ObjC vs Cpp
;; Could probably be improved...seems to only consider Cpp or what not.
(defun bh-choose-header-mode ()
  (interactive)
  (if (string-equal (substring (buffer-file-name) -2) ".h")
      (progn
	(let ((dot-m-file (concat (substring (buffer-file-name) 0 -1) "m" ))
	      (dot-cpp-file (concat (substring (buffer-file-name) 0 -1) "cpp")))
	      (if (file-exists-p dot-m-file)
		  (progn
		    (objc-mode)
		    )
		(if (file-exists-p dot-cpp-file)
		    (c++-mode)
		  )
		)
	      )
	)
    )
  )
(add-hook 'find-file-hook 'bh-choose-header-mode)


;; Go
(add-to-list 'load-path (concat emacs-dir "/go-mode.el-master"))
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))



;; css
(require 'sass-mode)
(custom-set-variables '(css-indent-offset 2))
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . sass-mode))

;; php
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-hook 'php-mode-hook '(lambda () (load-snippet-subdir-non-recursive "php-mode")))
(setq php-mode-force-pear t)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))

;; put blade *after* (not before) .php or php will take over blade file.
;; apparently this pushes blade in front of some kind of stack or order.
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(setq-default indent-tabs-mode nil)
(setq web-mode-code-indent-offset 4)
(setq web-mode-indent-style 4)

(autoload 'python-mode "python-mode" "Major mode for editing python code" t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))

;; To be able to work on PackageWright, which uses tab indendation liberally.
(add-hook 'python-mode-hook '(lambda ()
                               (setq indent-tabs-mode t)
                               (setq tab-width 2)
                               ))



(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby code" t)

(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(add-hook 'ruby-mode-hook '(lambda () (load-snippet-subdir-non-recursive "ruby-mode")))

(add-hook 'ruby-mode-hook '(lambda () (setq ruby-insert-encoding-magic-comment nil)))



(load "ruby-electric.elc")
(eval-after-load "ruby-mode"
  '(add-hook 'ruby-mode-hook 'ruby-electric-mode))

;; (load "python-mode.elc")
;; (load "ruby-mode.elc")


(require 'markdown-mode)
(let* ((data-dir (concat settings-dir "/common/data"))
       (footer-path (concat data-dir "/markdown-header.html"))
       (header-path (concat data-dir "/markdown-footer.html")))

  (custom-set-variables '(markdown-footer-file footer-path))
  (custom-set-variables '(markdown-header-file header-path)))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook '(lambda () (setq tab-width 4)))


;; Setup Erlang
(setq erlang-root-dir "C:/Program Files/erl5.7.1")
(setq exec-path (cons "C:/Program Files/erl5.7.1/bin" exec-path))
(require 'erlang-start)


(require 'haml-mode)
(require 'sass-mode)

(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))


(add-to-list 'auto-mode-alist '("\\.build" . ant-mode))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(custom-set-variables
 '(js2-basic-offset 2)  
 '(js2-bounce-indent-p t))
(setq js2-strict-missing-semi-warning nil)
(setq-default js2-global-externs '("setTimeout" "clearTimeout" "setInterval" "clearInterval"))



(setq js-indent-level 2)
      
(require 'json)

(autoload 'clojure-mode "clojure-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(require 'clojure-repl)


;; nxhtml
;; (load (concat emacs-dir "/nxhtml/autostart.el"))
;; (setq
;;  nxhtml-global-minor-mode t
;;  mumamo-chunk-coloring 'submode-colored
;;  nxhtml-skip-welcome t
;;  indent-region-mode t
;;  rng-nxml-auto-validate-flag nil
;;  nxml-degraded t)
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))
;; (custom-set-faces
;;  '(mode-line ((((type x w32 mac) (class color)) (:background "grey75" :foregroun d "black"))))
;;  '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) nil)))
;;  '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background dark)) (:background "DarkGreen")))))


;; Treat nant/ant build files as xml files
(add-to-list 'auto-mode-alist '("\\.build\\'" . nxml-mode))


;; Coffee script / coffee-mode
(defun coffee-custom ()
  "coffee-mode-hook"

  ;; (set (make-local-variable 'tab-width) 2)
  (setq coffee-js-mode 'javascript-mode)

  ;; If you don't want your compiled files to be wrapped
  (setq coffee-args-compile '("-c" "--bare"))

	(set (make-local-variable 'tab-width) 2)

  ;; *Messages* spam
  ;; (setq coffee-debug-mode t)

  ;; Emacs key binding
  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)

  ;; Riding edge.
  ;; (setq coffee-command "~/dev/coffee"))

  ;; Compile '.coffee' files on every save
  (add-hook 'after-save-hook
						'(lambda ()
							 (when (string-match "\.coffee$" (buffer-name))
								 (coffee-compile-file))))
  )

(autoload 'coffee-mode "coffee-mode" "Major mode for editing Coffee Script files" t)
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-hook 'coffee-mode-hook 'coffee-custom)
(require 'coffee-repl)


(defun my-csharp-mode-fn ()
  "function that runs when csharp-mode is initialized for a buffer."
  (message "setting tab width")
  (setq tab-width 4)
  (setq standard-indent 4)
  (setq indent-tabs-mode nil)
  )
(add-hook 'csharp-mode-hook 'my-csharp-mode-fn t)


(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))
(add-to-list 'auto-mode-alist '("\\.xaml$" . nxml-mode))



(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.m\\'" . objc-mode))


;; force interaction mode on lisp file...why not?
(add-to-list 'auto-mode-alist '("\\.el\\'" . lisp-interaction-mode))



(add-to-list 'load-path (concat emacs-dir "/scala-mode"))
(require 'scala-mode-auto)


;; Scheme
(add-to-list 'auto-mode-alist '("\\.scm\\'" . lisp-mode))
(setq inferior-lisp-program "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")



(require 'powershell-mode)
(add-to-list 'auto-mode-alist '("\\.ps1$" . powershell-mode))



(require 'slim-mode)



(require 'visual-basic-mode)
(add-to-list 'auto-mode-alist '("\\.vbs\\'" . visual-basic-mode))
(add-to-list 'auto-mode-alist '("\\.bas\\'" . visual-basic-mode))

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))
