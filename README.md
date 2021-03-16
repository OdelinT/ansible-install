
## L'inventaire

Défini dans apigee-container.yaml

## Config : quoi sur quel noeud

Dans apigee-build-planet, la variable apigee_topology

Remplir la liste de la façon suivante : 

- nomDataCenter nomHoteDansInventaire composantsAInstallerEnDeuxTroisLettres


## Commandes

### Lancer le conteneur hôte

Actuellement, le tout est basé sur le dockerfile du même nom pour CentOS. A la base, j'avais commencé par une instance de Debian, ne sachant pas que Apigee nécessitait yum. Cet ancien dockerfile existe toujours sous le nom debian-dockerfile, sans être utilisé.

/!\ la commande suivante ne marche pas pour l'instant car pas d'option pour lancer avec les privilèges (nécessaire pour Apigee)

~~~ sh
# script maison
DockillBuildRun apigeehost 222:22
~~~

Plan B

~~~ sh
docker build --rm -t apigeehost .
docker run --rm -it -d -p 222:22 --privileged apigeehost # à lancer autant de fois que souhaité en remplacant 222 par un port différent pour chaque instance
~~~

Script perso pour se connecter en bash sur le dernier container de l'image apigeehost

~~~ sh
# script maison
DocBash apigeehost
~~~

La commande complète :

~~~ sh
# lorsqu'il y a une seule instance de container issu de l'image apigeehost
docker exec -it $(docker ps -q --filter ancestor=apigeehost ) /bin/bash
# sinon
docker exec -it IdDeLaMachineParExempleTrouveeAvecDockerPs /bin/bash
~~~

### Config supplémentaire

On doit pouvoir se connecter en SSH à la machine

~~~ sh
ssh toto@127.0.0.1 -p 222
~~~

Si on a déjà accepté l'identité d'un autre conteneur situé auparavant sur le même port, il faut supprimer cette identité des hôtes connus

~~~ sh
vim ~/.ssh/known_hosts
~~~

Puis retenter de se connecter en SSH et accepter l'identité.

### Ansible

Lancer un test sur toutes les machines

~~~ sh
ansible all -i apigee-container.yaml -k -m ping
~~~

Lancer le playbook d'install

~~~ sh
ansible-playbook -i apigee-container.yaml -k apigee-build-planet.yml --extra-vars "ansible_sudo_pass=toto"
~~~


