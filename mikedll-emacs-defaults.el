;;
;; These settings are to separate emacs from its stupid default
;; behavior that I happen to disagree with. Like
;; disabling "happy menu icons" and the like.
;;

(defun font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))
(if (font-existsp "Monaco") (set-face-attribute 'default nil :font "Monaco"))

;; Does more harm than good
(global-set-key "\C-z" nil)

;; Start emacs in home, not C:/emacs/bin
;; http://stackoverflow.com/questions/60464/changing-the-default-folder-in-emacs
(setq default-directory (concat home-dir "/"))

;; Stop emacs' spam
(setq inhibit-startup-screen t)

;; Kill menu, tool bar, and scroll bar

(cond ((< emacs-major-version 24)
       (menu-bar-mode)
       (tool-bar-mode))
      (t
       (custom-set-variables
        '(menu-bar-mode nil)
        '(tool-bar-mode nil))))


(set-window-scroll-bars (minibuffer-window) nil)


;; The default vc-git mode is an interference to egg/magit.
(setq vc-handled-backends (remq 'Git vc-handled-backends))


;; Only search file names in dired
(require 'dired)
(require 'dired-isearch)
(define-key dired-mode-map (kbd "C-s") 'dired-isearch-forward)
(define-key dired-mode-map (kbd "C-r") 'dired-isearch-backward)
(define-key dired-mode-map (kbd "ESC C-s") 'dired-isearch-forward-regexp)
(define-key dired-mode-map (kbd "ESC C-r") 'dired-isearch-backward-regexp)

;; Emacs crashes without this on os x
(defun fix-tramp()
  ;; Hack to avoid tramp recursive load.
  (ido-mode)
  (require 'tramp)
  (ido-mode)
  )

(if (is-osx) (fix-tramp))

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode magit vue-mode rjsx-mode php-mode sass-mode))))


