# Charger le fichier de configuration
if [ -f /etc/autoreply/autoreply.cf ] ; then
	. /etc/autoreply/autoreply.cf
else
	exit
fi

# Extraction adresse expéditeur depuis l'entrée standard
# L'adresse peut occuper plusieurs ligne  si encodée en UTF8.
# => Résultat sur sortie standard.
function GetFromAddr {
local v
shift
v="${*}"
while [[ ! ${v} =~ @ ]] ; do
	read v
done	
v=${v#*<}
v=${v%>*}
v=${v%% *}
echo ${v}
}

# Envoyer contenu entrée standard par mail
# Variables obligatoires:
# - "mail_from"
# - "mail_subj"
# - "mail_to"
# Voir RFC pour les headers:
# - https://tools.ietf.org/html/rfc5230#section-5.6
function MailSend {
[[ -z "${mail_from}" || -z "${mail_subj}" || -z "${mail_to}" ]] && exit 1
mailutils filter -e quoted-printable |mail\
 -a "From: ${mail_from}"\
 -a "Message-ID: <vacation-$(RandomChain)@$(hostname -f)>"\
 -a "In-Reply-To: ${message_id}"\
 -a "Auto-submitted: auto-replied"\
 -a "Content-Type: text/plain; charset=utf-8"\
 -a "Content-Transfer-Encoding: quoted-printable"\
 -s "${mail_subj}"\
 ${mail_to}
}

# Gérérer une chaine aléatoire.
# => Résultat sur sortie standard.
function RandomChain {
local v
v="$(mktemp -u)-$(mktemp -u)"
echo "${v//\/tmp\/tmp./}"
}

# Encoder un header au format RFC 2047
# => Résultat sur sortie standard.
function HdrEncode {
mailutils 2047 -e --charset=utf-8 "${@}"
}

# Décoder un header au format RFC 2047
# => Résultat sur sortie standard.
function HdrDecode {
mailutils 2047 -d --charset=utf-8 "${@}"
}

# Permuter la position jour/mois d'une date JJ/MM/AAAA <=> MM/JJ/AAAA
# => Résultat sur sortie standard.
function DateSwap {
local d=${1}
d=${d//\// } # supprimer le "/"
d=(${d}) # convertir en tableau
echo "${d[1]}/${d[0]}/${d[2]}" # afficher la date permutée
}

# Convertir une date pour la substituion "sed"
# "xx/yy/AAAA" => "xx\/yy\/AAAA"
# => Résultat sur sortie standard.
function Date4Sed {
echo ${@//\//\\/}
}
