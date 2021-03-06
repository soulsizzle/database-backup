#!/bin/bash

################################
#  CONFIG                      #
################################

# GET THIS SCRIPTS DIRECTORY
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/config.cf


################################
#  MAGIC                       #
################################

# Create backup directory if it doesn't exist
if [ ! -d $SCRIPT_DIR/backups ]; then
    mkdir $SCRIPT_DIR/backups
fi

# Backup all DB's locally
for (( i = 0 ; i < ${#SERVERS[@]} ; i++ ))
do
    SQL_DESTINATION=$SCRIPT_DIR/backups/${SERVERS[$i]}_$SUFFIX.sql.gz

    # Save the MySQL dump locally
    echo Dumping database for ${SERVERS[$i]}
    ssh $SSH_USER@${SERVERS[$i]} "mysqldump -u$DB_USER -hlocalhost -p$DB_PASSWORD --all-databases" | gzip > $SQL_DESTINATION
done
