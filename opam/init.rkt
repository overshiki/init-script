#lang racket 

(system 
  "sudo apt-get install bubblewrap"
)

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
