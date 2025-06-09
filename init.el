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
  :hook (after-init . global-company-mode))

