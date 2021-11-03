echo
echo "Configuration de Git & GitHub"
echo
echo "Pour générer la clé SSH, tu as besoin de ton pseudo et email Github."

# Récupération pseudo Github
pseudo=""
while [ -z $pseudo ]
do 
    echo
    read -p "  1. Pseudo GitHub : " pseudo
    if [ -z  "$pseudo" ]
    then
        echo
        echo "Le pseudo doit être renseigné"
    fi
done

# Récupération email Github
email=""
while [ -z $email ]
do 
    echo
    read -p "  2. Email GitHub : " email
    if [ -z "$email" ]
    then
        echo
        echo "L'email doit être renseigné"
    fi
done

# Vérification des informations saisies
echo
echo "    Pseudo : $pseudo"
echo "    Email : $email"

echo
read -p "  3. Ces informations sont-elles exactes ? (y/n) : " confirm

if [ "$confirm" != "y" ]
then
    echo
    echo "    La clé n'a pas pu être générée. Veuillez relancer le script pour réessayer."
    exit 0;
else
    # Git config
    echo
    echo "  4. Paramétrage Git"
    echo
    git config --global user.name "$pseudo"
    git config --global user.email "$email"
    git config --global core.editor nano
    git config --global color.ui true
    git config -l

    # Création de la clé SSH
    echo
    echo "  5. Génération de la clé SSH"
    echo
    ssh-keygen -t ed25519 -N '' -C "$email" -f ~/.ssh/id_ed25519 <<< y
fi

# Vérification que le fichier contenant la clé existe bien
if [ -f ~/.ssh/id_ed25519.pub ]
then
    echo 
    echo " 6. Voici votre clé publique :" echo echo
    echo
    echo 
    echo "=========================="
    cat ~/.ssh/id_ed25519.pub
    echo "=========================="
fi