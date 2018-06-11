#!/bin/bash

cd /root/docsync
wget -r -A html --no-parent https://maprdocs.mapr.com/home/
find maprdocs.mapr.com -name "*.html" | xargs -L 1 -I '{1}' dirname {1} | xargs -L 1 -I {2} mkdir -p 'git/{2}'
find maprdocs.mapr.com -name "*.html" | xargs -L 1 -I '{1}' dirname {1} | xargs -L 1 -I {2} mkdir -p 'tmp/{2}'
find maprdocs.mapr.com/ -name "*.html" | xargs -L 1 -I '{}' sed -n '/<main role="main">/,/<\/main>/w tmp/{}' {}
find maprdocs.mapr.com -name "*.html" | xargs -L 1 -I '{}' sh -c "lynx -assume_charset=utf-8 -dump tmp/{} > git/{}"
cd git
git add .
git commit -am "Automated commit $(date)"
git push origin master
