(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")                                                                                       
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")     
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/"))) 
(package-refresh-contents)
(package-install 'use-package)
(package-install 'auto-highlight-symbol)
(package-install 'auto-complete)
(package-install 'highlight-parentheses)
(package-install 'clipmon)
(package-install 'highlight-indent-guides)
;; (package-install 'doom-themes)
(package-install 'go-mode)           ;; for go
(package-install 'haskell-mode)      ;; for haskell
(package-install 'futhark-mode)      ;; for futhark
(package-install 'racket-mode)       ;; for racket
(package-install 'tuareg)            ;; for ocaml
(package-install 'julia-mode)        ;; for julia
(package-install 'rust-mode)         ;; for rust
;; (package-install 'spacemacs-theme)
(package-install 'markdown-mode)     ;; for markdonw
(package-install 'elixir-mode)       ;; for elixir
(package-install 'scala-mode)        ;; for scala
