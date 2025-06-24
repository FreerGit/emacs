(use-package rustic
  :ensure t
  :hook (rustic-mode . lsp)
  :config
  :custom
  (rustic-rustfmt-config-alist '((edition . "2024")))
  (rustic-format-on-save t))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.4)
  (lsp-inlay-hint-enable nil)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints nil)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints nil)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  ;; :config
  ;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :bind
  (:map lsp-mode-map
	("C-c a" . lsp-execute-code-action)
	("C-c h" . lsp-describe-thing-at-point)))

(use-package lsp-ui
  :ensure t
  :config
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-doc-enable t)
  (eldoc-echo-area-use-multiline-p t)
  (lsp-ui-sideline-enable nil)
  :hook (lsp-mode . lsp-ui-mode))

(use-package toml-mode :ensure)

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets)
