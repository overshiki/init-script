
(package-install-file "deps/emacs-term-toggle/term-toggle.el")

(setq package-list
      '(
        company
        multiple-cursors
        use-package
        auto-highlight-symbol
        auto-complete
        highlight-parentheses
        clipmon
        highlight-indent-guides
        swiper-helm
        lsp-haskell
        doom-themes
        go-mode
        haskell-mode
        futhark-mode
        racket-mode
        tuareg         ;;; ocaml
        julia-mode
        rust-mode
        markdown-mode
        elixir-mode
        scala-mode
        ))

(setq package-files
      '(
        ;; deps start 
        "melpa/popup-20250101.843.tar"
        "melpa/dash-20250312.1307.tar"
        "melpa/shadchen-20141102.1839.tar"
        "melpa/ht-20230703.558.tar"
        ;; pkgs start 
        "melpa/company-20250911.129.tar"
        "melpa/multiple-cursors-20251006.2038.tar"
        "gnu/use-package.tar"
        "melpa/auto-highlight-symbol-20240627.650.tar"
        "melpa/auto-complete-20250101.843.tar"
        "melpa/highlight-parentheses-20240408.1126.tar"
        "melpa/clipmon-20180129.1054.tar"
        "melpa/highlight-indent-guides-20241229.2012.tar"
        ;; deps start
        "melpa/reformatter-20241204.1051.tar"
        "melpa/lv-20200507.1518.tar"
        "melpa/markdown-mode-20250812.423.tar"
        "gnu/spinner.tar"
        "melpa/s-20220902.1511.tar"
        "melpa/f-20241003.1131.tar"
        "melpa/lsp-mode-20251002.2344.tar"
        "melpa/wfnames-20240820.906.tar"
        "melpa/async-20251005.634.tar"
        "melpa/ivy-20250417.1209.tar"
        "melpa/swiper-20250329.1401.tar"
        "melpa/helm-core-20251005.539.tar"
        "melpa/helm-20251005.614.tar"
        ;; pkgs start 
        "melpa/swiper-helm-20180131.1744.tar"
        "melpa/lsp-haskell-20250301.213.tar"
        "melpa/doom-themes-20250924.2042.tar"
        "melpa/go-mode-20250311.156.tar"
        "melpa/haskell-mode-20250930.1728.tar"
        "melpa/futhark-mode-20250311.1518.tar"
        "melpa/racket-mode-20250830.1625.tar"
        ;; deps start
        "melpa/caml-20250227.1734.tar"
        ;; pkgs start 
        "melpa/tuareg-20250909.1604.tar"
        "melpa/julia-mode-20250407.841.tar"
        "melpa/rust-mode-20250705.1444.tar"
        "melpa/elixir-mode-20230626.1738.tar"
        "melpa/scala-mode-20241231.839.tar"
        )
      )

(dolist (package package-files)
  (package-install-file (concat "/root/mirror/" package)))

;; (package-initialize)
;; (dolist (package package-list)
;;   (unless (package-installed-p package)
;;     (package-install-file package)))
