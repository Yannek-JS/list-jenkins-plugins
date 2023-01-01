#! /bin/bash

##########################################################################
# This script gets the list of all plugins installed in Jenkins
##########################################################################

JENKINS_URL='http://localhost:8080/jenkins'	# URL under which Jenkins is achievable; do not end it with slash
START_TIME=$(date +%F__%T | sed 's/:/-/g')
PLUGINS_LIST_FILE='jenkins-plugin-list_'${START_TIME}'.txt'

echo -e "\nStarting listing Jenkins' plugins... \n"

# downloads current jenkins-cli.jar
echo -e -n '\nFinding jenkins-cli.jar...'
if [ -f 'jenkins-cli.jar' ]
then
    echo -e ' jenkins-cli.jar is alreadey downloaded and it will be used further. If something went wrong, you might consider updating it.\n\n'
else
    wget --quiet ${JENKINS_URL}/jnlpJars/jenkins-cli.jar
    if ! [ -f 'jenkins-cli.jar' ]
    then
        echo ' jenkins-cli.jar could not be downloaded. Quitting the script.'
        exit
    fi 
    echo -e ' downloaded\n\n'
fi


apiUser=''     # Jenkins user with Overall/Administer access
apiToken=''    # Jenkins API Token configured for an $apiUser

read -p 'Enter Jenkins API username: ' apiUser
read -p "Enter Jenkins API token for user $apiUser: " apiToken

echo -e '\n\n\nListing plugins...\n'

java -jar jenkins-cli.jar -auth ${apiUser}:${apiToken} -s $JENKINS_URL list-plugins | tee $PLUGINS_LIST_FILE
