#!/bin/bash

swarmMasterIP=52.23.238.170
swarmMasterSshPrivateKeyPath="./credential/up-devops-server.pem"
registryToken="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"

validateAppNames () {
    apps=("$@")

    for (( i=0; i<${#apps[@]}; i++ ));
    do
        appName=${apps[$i]}
        if [ ! -d "./microservice/$appName" ] && [ $appName != "all" ]
        then
            echo "App $appName doesn't exists." 
            exit 9999 # die with error code 9999
        fi
    done
}

buildAndPushAnApp () {
    appName=$1
    echo "------------- start build $appName -----------------"
    docker build -t ghcr.io/kbtdevops/micro-service/hrm/$appName ./microservice/$appName
    docker push ghcr.io/kbtdevops/micro-service/hrm/$appName
    echo "-------------- finish build $appName ---------------"
}

dockerLogin () {
    docker login ghcr.io -u kongbunthoeurn -p $registryToken
}

buildAndPushDocker () {
    apps=("$@")

    for (( i=0; i<${#apps[@]}; i++ ));
    do
        if [ $appName = "all" ]
        then
            for d in microservice/* ; do
                app=${d/microservice\//""}
                buildAndPushAnApp $app
            done
        else
            appName=${apps[$i]}
            buildAndPushAnApp $appName
        fi
    done
}

deployment () {
    scp -i $swarmMasterSshPrivateKeyPath docker-compose.yaml ubuntu@$swarmMasterIP:/opt/app/docker-compose.yaml
    # set up deployment
    ssh -o "StrictHostKeyChecking=no" -i $swarmMasterSshPrivateKeyPath ubuntu@$swarmMasterIP << EOF
        docker login ghcr.io -u kongbunthoeurn -p $registryToken
        docker stack deploy --with-registry-auth --prune --resolve-image=always -c /opt/app/docker-compose.yaml node
EOF
}

# clear
# echo "Welcome to automate micro service deployment"

# read -p "Please input apps : " inputArrayLocalPort

# validateAppNames $inputArrayLocalPort

# # docker login
# dockerLogin

# # build docker and push docker
# buildAndPushDocker $inputArrayLocalPort

deployment