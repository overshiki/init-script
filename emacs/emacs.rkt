#lang racket
(require racket/cmdline)
(require racket/match)

(define sys "none")
(command-line
 #:program "emacs-install"
 #:once-each
 [("-s") s "system" (set! sys s)])

(match sys
  ("ubuntu"
   (begin
     (display "ubuntu linux")
     (system "sudo apt-get install -y libgnutls28-dev libtinfo-dev pkg-config")))
  ("rocky"
   (begin
     (display "rocky linux")
   (system "sudo yum install -y gnutls pkg-config gnutls-devel ncurses-devel")))
  (_
   (display "system not recognized")))

(system "wget -c https://mirror.ossplanet.net/gnu/emacs/emacs-30.2.tar.xz")
(system "tar -xvf emacs-30.2.tar.xz")

(system "cd emacs-30.2 && ./configure && make -j4 && sudo make install")
(system "cp .emacs ~/")
(system "emacs --script emacs_install.el")
