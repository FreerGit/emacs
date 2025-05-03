;; M-x reload-config to reload this file
(defun reload-config ()
  (interactive)
  (load-file user-init-file))

(defun package-install-helper (package)
  "Install PACKAGE if it is not already installed."
  (unless (package-installed-p package)
    (package-install package)))

;; Melpa, package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install
(package-install-helper 'gruber-darker-theme) ;; Tsoding theme
(package-install-helper 'cider)               ;; cider, clj REPL
;;(package-install-helper 'clojure-ts-mode)     ;; tree-sitter support, clj
(package-install-helper 'magit)               ;; magic git

;; Auto start the REPL on clojure mode
(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'clojure-mode-hook 'cider-repl-autostart-mode)


;; UI cleanup
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; UI extensions
(load-theme 'gruber-darker t)
(global-display-line-numbers-mode t)  ;; Enable line numbers
(setq display-line-numbers-mode 'relative)  ;; relative line nums
