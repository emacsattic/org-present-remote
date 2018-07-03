(require 'package)

(package-initialize)

(setq package-archives '(("org" . "https://orgmode.org/elpa/")))
(package-refresh-contents)
(package-install org org-plus-contrib)

(add-to-list 'package-archives '("gnu" . "http://melpa.org/packages/") t)
(package-refresh-contents)
(package-install org-present)

(require 'org)

(message (format "Emacs %s" emacs-version))
(message (format "org %s" org-version))
(message (format "org in %s" (locate-library "org")))
