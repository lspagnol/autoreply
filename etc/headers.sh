########################################################################

# Ce script est utilisé pour extraire des headers supplémentaires / non
# prévus dans le script principal.

########################################################################

# Exemple: extraction des headers spécifiques de l'URCA

case ${H} in

	# Identifiant utilisateur
	x-urca-user:)
		user=${L[1],,}
	;;

	# Adresse ip
	x-urca-host:)
		ip=${L[1],,}
	;;
	
esac
