#lang racket
(require "../lib.rkt")
(require racket/cmdline)
(require racket/match)

;; (define sys "none")
(define mode "none")
(command-line
   #:program "emacs-install"
   #:once-each
   ;; [("-s") s "system" (set! sys s)]
   [("-m") m "full" (set! mode m)]
   )

(define sys (get-os))

(define is-post
  (match mode
    ["post" #t]
    ["full" #f]
    [_ (raise "need -m for mode: full || post" #t)]
    )
  )

(when (not is-post) 
   (match sys
     ('ubuntu
      (begin
        (display "ubuntu linux")
        (system "sudo apt-get update")
        (system "sudo apt-get install -y libgnutls28-dev libtinfo-dev pkg-config libgccjit-12-dev ripgrep")))
     ('rocky
      (begin
        (display "rocky linux")
        (system "sudo yum install -y gnutls pkg-config gnutls-devel ncurses-devel zlib zlib-devel libgccjit libgccjit-devel ripgrep")))
     ;; nothing matched
     (_
      (display "system not recognized"))
      (raise 'failed #t)
     )
   (system "wget -c https://mirror.ossplanet.net/gnu/emacs/emacs-30.2.tar.xz")
   (system "tar -xvf emacs-30.2.tar.xz")
   (system "cd emacs-30.2 && ./configure && make -j4 && sudo make install")
   )


(when (not (directory-exists? "deps"))
  (system "mkdir deps")
  (system "cd deps && git clone https://github.com/amno1/emacs-term-toggle.git")
  )
 
(system "emacs --script install.el")

(system "cp .emacs ~/")

