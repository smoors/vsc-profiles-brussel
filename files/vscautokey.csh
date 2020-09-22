set minuid=2500000
set myid=`id -u`
if ( ${myid} > ${minuid} ) then
    if ( ! -e ~/.ssh/id_rsa ) then
        if ( -w ~/) then
            ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -q -N ""
            chmod 600 ~/.ssh/authorized_keys
            cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
            chmod 400 ~/.ssh/authorized_keys ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
        endif
    endif
endif
