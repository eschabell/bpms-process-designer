#!/bin/sh 
DEMO="JBoss BPM Suite Process Designer Demo"
AUTHORS="Eric D. Schabell"
PROJECT="https://github.com/eschabell/bpms-process-designer.git"
JBOSS_HOME=./target/jboss-eap-6.1
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_MODULE=$JBOSS_HOME/modules/
SERVER_BIN=$JBOSS_HOME/bin
SUPPORT_DIR=./support
SRC_DIR=./installs
EAP=jboss-eap-6.1.0.zip

# wipe screen.
clear 

echo
echo "##################################################################"
echo "##                                                              ##"   
echo "##  Setting up the ${DEMO}        ##"
echo "##                                                              ##"   
echo "##                                                              ##"   
echo "##              ####   ####    #   #    ###                     ##"
echo "##              #   #  #   #  # # # #  #                        ##"
echo "##              ####   ####   #  #  #   ##                      ##"
echo "##              #   #  #      #     #     #                     ##"
echo "##              ####   #      #     #  ###                      ##"
echo "##                                                              ##"   
echo "##                                                              ##"   
echo "##  brought to you by,                                          ##"   
echo "##             ${AUTHORS}                                 ##"
echo "##                                                              ##"   
echo "##  ${PROJECT}      ##"
echo "##                                                              ##"   
echo "##################################################################"
echo

# make some checks first before proceeding.	
if [[ -r $SRC_DIR/$EAP || -L $SRC_DIR/$EAP ]]; then
		echo EAP sources are present...
		echo
else
		echo Need to download $EAP package from the Customer Support Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

# Create the target directory if it does not already exist.
if [ ! -x target ]; then
		echo "  - creating the target directory..."
		echo
		mkdir target
else
		echo "  - detected target directory, moving on..."
		echo
fi

# Move the old JBoss instance, if it exists, to the OLD position.
if [ -x $JBOSS_HOME ]; then
		echo "  - existing JBoss Enterprise EAP 6 detected..."
		echo
		echo "  - moving existing JBoss Enterprise EAP 6 aside..."
		echo
		rm -rf $JBOSS_HOME.OLD
		mv $JBOSS_HOME $JBOSS_HOME.OLD

		# Unzip the JBoss EAP instance.
		echo Unpacking JBoss Enterprise EAP 6...
		echo
		unzip -q -d target $SRC_DIR/$EAP
else
		# Unzip the JBoss EAP instance.
		echo Unpacking new JBoss Enterprise EAP 6...
		echo
		unzip -q -d target $SRC_DIR/$EAP
fi

echo "  - setting up standalone.xml configuration adjustments..."
echo
cp $SUPPORT_DIR/standalone.xml $SERVER_CONF

echo "  - deploying process designer app..."
echo
unzip -q -d $SERVER_DIR $SUPPORT_DIR/jbpm-designer.war.zip
touch ${SERVER_DIR}jbpm-designer.war.dodeploy

# Add execute permissions to the standalone.sh script.
echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

echo "You can now start the server with $SERVER_BIN/standalone.sh"
echo

echo "${DEMO} Setup Complete."
echo

