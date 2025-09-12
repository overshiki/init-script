#lang racket
(system "sudo apt-get install -y libgnutls28-dev libtinfo-dev pkg-config") 
(system "wget -c https://mirror.ossplanet.net/gnu/emacs/emacs-30.2.tar.xz")
(system "tar -xvf emacs-30.2.tar.xz")

(system "cd emacs-30.2 && ./configure && make -j4 && sudo make install")

