;; Flycheck + clj-kondo
(use-package flycheck-clj-kondo
  :after (flycheck clojure-ts-mode)
  :config
  (with-eval-after-load 'clojure-ts-mode
    (add-to-list 'flycheck-checkers 'clojure-ts-clj-kondo)))

;; CIDER (Clojure REPL)
(use-package cider
  :hook (clojure-ts-mode . cider-mode)
  :config
  (setq cider-repl-use-pretty-printing t)
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'clojure-ts-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'cider-format-buffer nil t))))

;; Clojure TS Mode (prefer over clojure-mode)
(use-package clojure-ts-mode
  :mode "\\.clj[cs]?\\'"
  :init
  (dolist (remap '((clojure-mode . clojure-ts-mode)
                   (clojurescript-mode . clojure-ts-mode)
                   (clojurec-mode . clojure-ts-mode)))
    (add-to-list 'major-mode-remap-alist remap))
  :hook
  (clojure-ts-mode . (lambda ()
                       (setq-local flycheck-check-syntax-automatically
                                   '(save mode-enabled)))))
