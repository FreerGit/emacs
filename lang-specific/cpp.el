(use-package c++-ts-mode
  :ensure nil  ; built-in in Emacs 29+
  :hook (c++-ts-mode . lsp)
  :mode ("\\.cpp\\'" "\\.cxx\\'" "\\.cc\\'" "\\.C\\'")
  :config
  ;; Format on save (requires clang-format)
  (add-hook 'c++-ts-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'clang-format-buffer nil 'local))))

(use-package clang-format
  :ensure t
  :config
  (setq clang-format-style "Google"))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-clients-clangd-args '("--header-insertion=iwyu"
                             "--completion-style=detailed"
                             "--function-arg-placeholders"
                             "--clang-tidy"))
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.4)
  (lsp-inlay-hint-enable nil)
  (lsp-clients-clangd-inlay-hints-enable nil)
  :bind
  (:map lsp-mode-map
        ("C-c a" . lsp-execute-code-action)
        ("C-c h" . lsp-describe-thing-at-point)
        ("C-c r" . lsp-rename)
        ("C-c f" . lsp-format-buffer)))

(use-package lsp-ui
  :ensure t
  :config
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-doc-enable t)
  (eldoc-echo-area-use-multiline-p t)
  (lsp-ui-sideline-enable nil)
  :hook (lsp-mode . lsp-ui-mode))

(use-package modern-cpp-font-lock
  :ensure t
  :hook (c++-mode . modern-c++-font-lock-mode))
