#lang racket
(system "mkdir -p ~/.config/tmux/plugins/catppuccin")
(let ((dir "~/.config/tmux/plugins/catppuccin/tmux"))
  (unless (not (directory-exists? dir)) 
    (system (string-append "git clone -b v2.1.3 https://github.com/catppuccin/tmux.git " dir))))

(system "~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux")
(system "cp .tmux.conf ~/")
;; (system "tmux source ~/.tmux.conf")
