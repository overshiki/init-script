#lang racket 
(require "../lib.rkt")
(require racket/cmdline)
(require racket/match)

;; (define sys "none")
;; (command-line
;;  #:program "emacs-install"
;;  #:once-each
;;  [("-s") s "system" (set! sys s)])

(define sys (get-os))

(match sys
  ('ubuntu
   (begin
     (display "ubuntu linux")
     (system "sudo apt-get install -y bubblewrap")
     ))
  ('rocky
   (begin
     (display "rocky linux")
     (system "sudo yum install -y bubblewrap")))
  (_
   (display "system not recognized")))


(system 
  "bash -c \"sh <(curl -fsSL https://opam.ocaml.org/install.sh)\""
)

(system 
  "opam init"
)

(system 
  "eval $(opam env)"
)

;;(system "opam install torch.0.13")
