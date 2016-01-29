
### root_prepare_server.sh :

Installe les paquets Debian du serveur

### root_chroot_prepare_chroot.sh :

Crée l'environnement chroot.

### root_chroot_run_sshd.sh : 

Lance le serveur sshd de l'environnement chroot (sur le 2222).

### ssh-guest :

# idem ssh -o NoHostAuthenticationForLocalhost=yes -p 2222 $@

### scp-guest :

# idem scp -o NoHostAuthenticationForLocalhost=yes -P 2222 $@



