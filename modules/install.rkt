#lang racket
(system "yum install -y tcl tcl-devel")
(system "wget -c https://sourceforge.net/projects/modules/files/Modules/modules-5.6.0/modules-5.6.0.tar.gz")
(system "tar -xzvf modules-5.6.0.tar.gz")
(system "cd modules-5.6.0 && ./configure && make -j4 && make install")
