#lang racket 

(define sys "none")
(command-line
 #:program "emacs-install"
 #:once-each
 [("-s") s "system" (set! sys s)])

(match sys
  ("ubuntu"
   (begin
     (display "ubuntu linux")
     (system "sudo apt-get install -y libgmp-dev")))
  ("rocky"
   (begin
     (display "rocky linux")
     (system "sudo yum install -y gmp-devel")))
  (_
   (display "system not recognized")))


(system 
  "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
)


