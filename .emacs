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
(package-install-helper 'tree-sitter)         ;; tree sitter
(package-install-helper 'tree-sitter-langs)   ;; 
(package-install-helper 'gruber-darker-theme) ;; Tsoding theme
(package-install-helper 'cider)               ;; cider, clj REPL
(package-install-helper 'clojure-ts-mode)     ;; clj major mode, treesitter 
(package-install-helper 'magit)               ;; magic git
(package-install-helper 'company)             ;; complete anything
(package-install-helper 'flycheck-clj-kondo)  ;; clj-kondo linter

;; Global hooks
(require 'company)
(global-company-mode 1)

;; --- Clojure specific setup ---
;; Auto start the REPL on clojure mode
;; Prefer clojure-ts-mode over clojure-mode
(add-to-list 'major-mode-remap-alist '(clojure-mode . clojure-ts-mode))
(add-to-list 'major-mode-remap-alist '(clojurescript-mode . clojure-ts-mode))
(add-to-list 'major-mode-remap-alist '(clojurec-mode . clojure-ts-mode))
(add-hook 'clojure-ts-mode-hook #'cider-mode)
(add-hook 'clojure-ts-mode-hook #'flycheck-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)

(add-hook 'clojure-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'cider-format-buffer t t)))
(setq cider-repl-use-pretty-printing t)

(with-eval-after-load 'clojure-ts-mode
  (require 'flycheck-clj-kondo)
  (flycheck-define-checker clojure-ts-clj-kondo
    "A Clojure syntax and lint checker using clj-kondo."
    :command ("clj-kondo" "--lint" source)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": warning: " (message) line-end)
     (error line-start (file-name) ":" line ":" column ": error: " (message) line-end))
    :modes (clojure-ts-mode clojurescript-ts-mode clojurec-ts-mode))

  (add-to-list 'flycheck-checkers 'clojure-ts-clj-kondo))

;; --- Clojure setup END ---

;; UI cleanup
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
									
;; UI extensions
(global-font-lock-mode 1)				
(load-theme 'gruber-darker t)
(global-display-line-numbers-mode 1)  ;; Enable line numbers
(setq display-line-numbers-type 'relative)

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
