
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(package-selected-packages
   '(acm all-the-icons-dired avy chatgpt-shell company dashboard diminish
	 dired-open dired-preview dmenu doom-modeline doom-themes dune
	 eat ef-themes eglot elfeed elixir-ts-mode emmet-mode
	 engrave-faces envrc eshell-syntax-highlighting eshell-toggle
	 evil-collection evil-commentary evil-goggles flycheck-ocaml
	 general git-timemachine hl-todo hydra ligature lsp-bridge
	 lsp-mode magit merlin-eldoc nimbus-theme nix-mode ocamlformat
	 orderless org-drill org-fancy-priorities org-roam pdf-tools
	 perspective plantuml-mode projectile python-black
	 rainbow-delimiters tree-sitter-langs tuareg use-package
	 vertico-posframe vterm-toggle which-key yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
