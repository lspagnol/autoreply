# Notice utilisateur

## Généralités

* Le répondeur automatique est contrôlé par mail.

* L'adresse mail à contacter pour régler le répondeur est de la forme _MAIL-**autoreply**@DOMAINE_.
* Exemple:
  * pour l'adresse «adresse-test@mondomaine.fr»,
  * l'adresse à contacter est «adresse-test-autoreply@mondomaine.fr».

* Une commande **DOIT** être indiquée dans le champ «Sujet» / «Objet».

* Une demande d'aide peut être envoyée à un adresse générique dédiée de la forme _autoreply@DOMAINE_.
* Exemple:
  * pour le domaine «mondomaine.fr»,
  * l'adresse à contacter est «autoreply@mondomaine.fr».

## Les commandes du répondeur

* **help**
  * **Demander la notice d'utilisation du répondeur.**
  * La notice sera envoyée à l'expéditeur.

* **status**
  * **Demander l'état du répondeur.**
  * Une notification d'état sera envoyée à l'expéditeur.

* **enable**
  * **Activer le répondeur.**
  * Par défaut (aucune date n'est indiquée à la suite de la commande _enable_), le répondeur est activé pour la journée en cours.
  * Si une date est indiquée (format **JJ/MM/AAAA**), le répondeur sera activé pour cette date.
  * Si une seconde date est indiquée, le répondeur sera activé sur cette plage de dates.
  * Exemples:
    * Pour activer le répondeur aujourd'hui, indiquer simplement «enable» dans le sujet.
    * Pour activer le répondeur le 1/1/2017 ⇒ «enable 1/1/2017».
    * Pour activer le répondeur du 1/1/2017 au 5/1/2017 ⇒ «enable 1/1/2017 5/1/2017».
  * Une notification d'état sera envoyée à l'expéditeur ET à l'adresse mail concernée par ce répondeur.

* **disable**
  * **Désactiver le répondeur.**
  * Une notification d'état sera envoyée à l'expéditeur ET à l'adresse mail concernée par ce répondeur.

* **answer record**
  * **Enregistrer le message du répondeur.**
  * Le texte présent dans le message sera enregistré comme texte du répondeur.
  * Le message **DOIT** être envoyé au format **TEXTE SIMPLE** (pas de HTML).
  * Lors des réponses, la chaine de caractères «##DATES##» sera remplacée automatiquement par la date ou la plage de dates d'activation.
  * L'article («le», «aujourd'hui», «du», «au») est implicite.
  * Exemple avec le texte «Le service est fermé ##DATES##.»:
    * Activation ⇒ le 1/1/2017
      * **Réponse** ⇒ «Le service est fermé aujourd'hui.»
    * Activation ⇒ du 1/1/2017 au 5/1/2017
      * **Réponse** ⇒ «Le service est fermé du 1/1/2017 au 5/1/2017 inclus.»
  * Une notification d'état sera envoyée à l'expéditeur ET à l'adresse mail concernée par ce répondeur.

* **answer default**
  * **Supprimer le message du répondeur.**
  * Le message par défaut sera utilisé.
  * Une notification d'état sera envoyée à l'expéditeur ET à l'adresse mail concernée par ce répondeur.
