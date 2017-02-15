# Notice d'installation

## Prérequis
 * MTA: Postfix,
 * commandes: «diff», «mailutils» et «git» (pour l'installatiob).

## Installation des scripts
 * Télécharger les scripts: ``git clone https://github.com/lspagnol/autoreply``
 * Installer les scripts: ``cd autoreply ; chmod +x install.sh ; ./install.sh``

## Configuration

### Postfix
Le fichier **/etc/postfix/main.cf** doit être modifié.
 * AJOUTER le paramètre «recipient_bcc_maps»:
````
...
recipient_bcc_maps = hash:/etc/autoreply/bcc-reply
...
````
 * AJOUTER les tables d'aliases du répondeur:
````
...
alias_maps = ...
             ...
             hash:/etc/autoreply/aliases-reply
             hash:/etc/autoreply/aliases-config
...
...
alias_database = ...
                 ...
             hash:/etc/autoreply/aliases-reply
             hash:/etc/autoreply/aliases-config
...
...
````
### Planification
Planifier le script de mise à jour des tables du répondeur «aliases2autoreply», exemple:
````
# Mise à jour tables répondeur
4-59/5  *       * * *   root    /usr/local/autoreply/aliases2autoreply /etc/sympa/adresses_generiques
````
