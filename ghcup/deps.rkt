#lang racket 

(system 
  "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
)

(system "apt-get install libgmp-dev")
