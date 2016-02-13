# Documents de reference

#### BASH

* [The BASH Guide](http://guide.bash.academy/)
* [The BASH Hackers Wiki](http://wiki.bash-hackers.org/)
* [Defensive BASH Programming](http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming)
* [Unofficial BASH Strict Mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)

# Comment faire ses commits depuis le compte info@fraise

* Faire ses modifications avec son editeur preféré
* Ajouter seulement les fichiers que vous avez modifiés:  `git add fichier1.sh fichier2.sh`

Il y a des alias qui existent pour faciliter le "CommitAndPush" et ainisi maximiser votre productivité. Chaque alias est specifique à un utilisateur.

* `cap1`: `gudavala`
* `cap2`: `jegrand5`
* `cap3`: `lijack`
* `cap4`: `mamoulin11`
* `cap5`: `flmousse`
* `cap6`: `pipic1`

NB: Si l'alias vous deplait il peut être modifié dans le fichier `/home/info/.bash_aliases`

Donc, prenons par exemple l'étudiant `lijack` qui vient de modifier le fichier `Question.sh`, il va executer les commandes suivantes:

* `git add Question.sh`
* `cap3`

Le "CommitAndPush" s'occupe de faire le commit, et vous demande seulement le message de commit. Il peut également s'occuper de l'authentification si vous l'autorisez, mais pour cela je vous conseille avant tout d'obtenir un token OAuth pour votre compte Github (évite de devoiler votre mot de passe à tout le monde)

# Token OAuth Github

* Ouvrir la page suivante: https://github.com/settings/tokens
* Cliquer sur "Generate new token"
* Mettre `info@fraise` dans le champ "Token description"
* Cocher seulement `public_repo`
* Cliquer sur "Generate token"
* Copier le token indiqué par la flèche (oui la chaine de 40 caractères) dans le presse papier, ne pas le perdre avant l'avoir ajouté à CommitAndPush
  ![Imgur](http://i.imgur.com/6oCpj4h.png)

# Ajout du Token OAuth dans CommitAndPush

* `git add fichier1.sh`
* `cap3`

```
    $ git add fichier1.sh
    $ cap3
    Souhaitez-vous stocker votre token OAuth sur info@fraise ? [o/N] o
    Password for 'https://cuonic@github.com': [COLLER TOKEN OAUTH ICI]
````

C'est ajouté, lors de vos prochains commit vous n'aurez pas à rentrer de nom d'utilisateur, ni de mot de passe. Maintenant, codez.
