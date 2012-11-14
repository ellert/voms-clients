#!/bin/bash
#set -x

VOMSCLIENT_LIBS=${voms-clients.libs}

if [ "x$VOMSCLIENT_LIBS" == "x" ]; then

  PRG="$0"
  while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
      PRG="$link"
    else
      PRG=`dirname "$PRG"`/"$link"
    fi
  done

  PRGDIR=`dirname "$PRG"`

  VOMSCLIENTS_HOME=`cd "$PRGDIR/.." ; pwd`

  VOMSCLIENTS_LIBS=$VOMSCLIENTS_HOME/share/java

fi

# ':' separated list of jars, for the classpath
VOMSCLIENTS_CP=`ls -x $VOMSCLIENTS_LIBS/*.jar | tr '\n' ':'`

# the class implementing voms-proxy-init
VOMSPROXYINIT_CLASS="org.italiangrid.voms.clients.VomsProxyInit"

java -DeffectiveUserId=$EUID -cp $VOMSCLIENTS_CP $VOMSPROXYINIT_CLASS "$@"
