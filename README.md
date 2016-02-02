## Documents de reference

#### BASH

* [The BASH Guide](http://guide.bash.academy/)
* [The BASH Hackers Wiki](http://wiki.bash-hackers.org/)
* [Defensive BASH Programming](http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming)
* [Unofficial BASH Strict Mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)

## Comment utiliser git

#### Depuis le compte info@fraise

Ajouter les modification apportés:

`git add *`

Le script suivant s'occupe de commit et pousse les modifications, à votre nom:

`~/Code/bin/CommitAndPush.sh [NOM D'UTILISATEUR]`

#### Supprimer un fichier

`git rm [FICHIER A SUPPRIMER]`

#### Ajouter ses modifications

`git add *`

#### Commit ses modifications

`git commit -m "[MESSAGE]"`

#### Pousser ses modifications

`git push origin master`

#### Recuperer des modifications

`git pull origin master`

#### Annuler un commit

`git reset HEAD^`

