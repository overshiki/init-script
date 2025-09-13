#lang racket 

(system 
  "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
)

(system "apt-get install libgmp-dev")

(system 
  "wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
)

(system 
  "git clone https://github.com/hasktorch/hasktorch.git"
)
