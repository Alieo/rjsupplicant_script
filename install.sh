#!/bin/bash

nowpath=`pwd`

cd $nowpath

chmod +x *

echo '############ruijie########' >> ~/.bashrc

echo "export \$PD=\"$1\" "  >> ~/.bashrc
echo "export \$CNC=\"$2\" " >> ~/.bashrc
echo "alias rj='fun(){ $nowpath/rj.sh \$1;  }; fun' " >> ~.bashrc

echo '############ruijie########' >> ~/.bashrc

sources ~/.bashrc
