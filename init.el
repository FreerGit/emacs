;; Reload config
(defun reload-config ()
  (interactive)
  (load-file user-init-file))

;; Package setup
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Install use-package itself if needed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Theme
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; Company (autocomplete)
(use-package company
 :init
 (global-company-mode))

;; Load lang specific configs
(defvar config-dir
  (file-name-directory (file-truename load-file-name)))

;; Set up the lang-specific directory path
(defvar lang-specific-dir
  (expand-file-name "lang-specific" config-dir))

;; Add the lang-specific directory to load-path
(add-to-list 'load-path lang-specific-dir)

;; Now you can load the files
(load-file (expand-file-name "clojure.el" lang-specific-dir))
(load-file (expand-file-name "rust.el" lang-specific-dir))
(load-file (expand-file-name "python.el" lang-specific-dir))

;; UI cleanup
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
									
;; UI extensions
(global-font-lock-mode 1)				
(load-theme 'gruber-darker t)
(global-display-line-numbers-mode 1)  ;; Enable line numbersAdd commentMore actions
(setq display-line-numbers-type 'relative)
(add-hook 'after-change-major-mode-hook (lambda () (text-scale-set -2))) ;; default zoom

;; Tell emacs to shut up
(setq ring-bell-function 'ignore)

;; Re-map keys
(defun mark-backward-paragraph ()
  "Move backward a paragraph and mark the region."
  (interactive)
  (unless (region-active-p)
    (set-mark-command nil))
  (backward-paragraph))

(defun mark-forward-paragraph ()
  "Move forward a paragraph and mark the region."
  (interactive)
  (unless (region-active-p)
    (set-mark-command nil))
  (forward-paragraph))

(keymap-global-set "M-[" 'backward-paragraph)
(keymap-global-set "M-]" 'forward-paragraph)
(keymap-global-set "M-{" 'mark-backward-paragraph)
(keymap-global-set "M-}" 'mark-forward-paragraph)

;; Saner word-by-word forward/backward
(defun my-forward-same-syntax (arg)
  "Move forward by ARG units of same syntax."
  (interactive "p")
  (forward-same-syntax arg))

(defun my-forward-same-syntax-mark (arg)
  "Move forward by ARG units of same syntax, extending the selection."
  (interactive "p")
  ;; If mark is not active, activate it at point before moving
  (unless (region-active-p)
    (set-mark (point)))
  (forward-same-syntax arg))

(global-set-key (kbd "M-f") #'my-forward-same-syntax)
(global-set-key (kbd "M-b") (lambda () (interactive) (my-forward-same-syntax -1)))
(global-set-key (kbd "M-F") #'my-forward-same-syntax-mark)
(global-set-key (kbd "M-B") (lambda () (interactive) (my-forward-same-syntax-mark -1)))

;; I just got DESTROYED by accidentally hitting this, not again.
(global-unset-key (kbd "C-x C-c"))
