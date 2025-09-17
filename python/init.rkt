#lang racket

(system 
  "wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
  )
(system "bash ./Miniconda3-latest-Linux-x86_64.sh")
(system "pip install fpm")
