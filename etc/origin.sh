########################################################################

# Ce script est utilisé pour vérifier si une demande de configuration
# est légitime.

# Il peut initialiser le contenu de la variable ORIGIN qui est utilisée
# dans le sujet des messages de notification.

########################################################################

# Exemple: traitement spécifique aux headers de l'URCA

# Expéditeur inconnu => FIN
[[ -z "${user}" || "${user}" = "UNKNOWN" ]] && exit 0

# IP d'expédition inconnue => FIN
[[ -z "${ip}" || "${ip}" = "UNKNOWN" ]] && exit 0

# Origine de la demande
ORIGIN="${from}/${user}/${ip}"
