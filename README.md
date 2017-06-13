# autoreply
Generic and autonomous mail answering machine, RFC 3834 compliant.

**autoreply** est un répondeur automatique générique et autonome.
Il a éte conçu pour répondre à la problématique des adresses génériques gérées par un serveur de listes de diffusion tel que **Sympa** (https://www.sympa.org):
* Sympa lui-même ne dispose pas nativement de la fonction «répondeur automatique»,
* les implémentations de Sieve (conformes à la RFC 5230 section 4.6) n'autorisent pas le déclenchement du répondeur dans ce contexte car les destinataires d'une adresse générique sont des abonnés d'une liste de diffusion.

**autoreply** s'appuie sur le MTA **Postfix** et deux scripts Shell, les répondeurs sont contrôlés par mail et leur comportement est conforme à la RFC 3834.

## Fonctionnement
 * Il repose sur 3 tables **Postfix**:
  * «bcc-reply» permet de rediriger une copie des mails vers les adresses de la table «aliases-reply»,
  * «aliases-reply» invoque le script du répondeur (son contenu n'est connu que du MTA local),
  * «aliases-config» invoque le script de configuration du répondeur (le contenu doit être diffusé / connu à l'extérieur du MTA local, mais il ne devrait pas être connu des serveurs MX).
 * Le script **reply** assure la fonction «répondeur automatique».
 * Le script **config** permet de traiter les commandes de configuration du répondeur par l'intermédiaire d'adresses dont la partie «alias» a le sufixe «-autoreply»:
  * Si l'adresse est «_MAIL@DOMAINE_»,
  * son répondeur se configure via l'adresse «_MAIL**-autoreply**@DOMAINE_».

## Exemple
 * La table d'aliases principale **/etc/postfix/aliases** contient:
````
nom.prenom1: boite1
nom.prenom2: boite2 
nom.prenom3: boite3
````
 * Si on souhaite que les adresses «nom.prenom1» et «nom.prenom2» disposent d'un répondeur, une copie cachée des mails (**bcc**) sera acheminée respectivement vers «nom.prenom1-reply» et «nom.prenom2-reply» grâce à la table **/etc/autoreply/bcc-reply**:
````
nom.prenom1 nom.prenom1-reply
nom.prenom2 nom.prenom2-reply
````
 * La table **/etc/autoreply/aliases-reply** permet d'injecter les messages dans le répondeur:
````
nom.prenom1-reply: "| /usr/local/autoreply/reply nom.prenom1@DOMAINE"
nom.prenom2-reply: "| /usr/local/autoreply/reply nom.prenom2@DOMAINE"
````
 * La table **/etc/autoreply/aliases-config** permet d'envoyer les commandes de configuration au répondeur:
````
nom.prenom1-autoreply: "| /usr/local/autoreply/config nom.prenom1@DOMAINE"
nom.prenom2-autoreply: "| /usr/local/autoreply/config nom.prenom2@DOMAINE"
````

## Références:
 * https://www.ietf.org/rfc/rfc3834.txt (Recommendations for Automatic Responses to Electronic Mail)
 * https://www.ietf.org/rfc/rfc5230.txt (Sieve Email Filtering: Vacation Extension)
