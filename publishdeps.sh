# TODO: Add help and handling null arguments
POM_PATH=/Users/mey/Projects/scm_mobile_sdk/pom.xml
SETTING_FILE_PATH=/Users/mey/.m2/settings.xml
REPOSITORY_ID=Meynisa
REPOSITORY_URL=https://github.com/Meynisa/scm_mobile_sdk

echo $POM_PATH
echo $SETTING_FILE_PATH
echo $REPOSITORY_ID
echo $REPOSITORY_URL

POM_NAME=$(basename "${POM_PATH}")
LIB_PATH=$(echo $POM_PATH | sed -e "s/.pom//")
POM_DIR=$(dirname "${POM_PATH}")

# When pom file contains multiple aar with different classifier, it should be uploaded separately.
if [[ -e "${LIB_PATH}-debug.aar" ]] && [[ -e "${LIB_PATH}-profile.aar" ]] && [[ -e "${LIB_PATH}-release.aar" ]]
then
    echo "It's classifier based library!"
    
    # TODO: HOTFIX, it should be removed after release of flutter 3.5 (with this issue https://github.com/flutter/flutter/issues/113417#issuecomment-1283253281)
    echo "Fix buggy pom file to remove pom packaging."
    sed -e "s/\<packaging\>pom\<\/packaging\>/\<packaging\>aar\<\/packaging\>/" $POM_PATH > "${POM_PATH}_mod"
    cp $POM_PATH "${POM_PATH}_back"
    mv "${POM_PATH}_mod" $POM_PATH

    echo "Upload release classifier library..."
    mvn -s $SETTING_FILE_PATH deploy:deploy-file \
        -DrepositoryId=$REPOSITORY_ID -Durl=$REPOSITORY_URL -DpomFile=$POM_PATH \
        -Dfile="${LIB_PATH}-release.aar" -Dclassifier=release

    echo "Upload profile classifier library..."
    mvn -s $SETTING_FILE_PATH deploy:deploy-file \
        -DrepositoryId=$REPOSITORY_ID -Durl=$REPOSITORY_URL -DpomFile=$POM_PATH \
        -Dfile="${LIB_PATH}-profile.aar" -Dclassifier=profile

    echo "Upload debug classifier library..."
    mvn -s $SETTING_FILE_PATH deploy:deploy-file \
        -DrepositoryId=$REPOSITORY_ID -Durl=$REPOSITORY_URL -DpomFile=$POM_PATH \
        -Dfile="${LIB_PATH}-debug.aar" -Dclassifier=debug

else
    echo "It's common aar library!"
    echo "Upload library..."

    mvn -s $SETTING_FILE_PATH deploy:deploy-file \
        -DrepositoryId=$REPOSITORY_ID -Durl=$REPOSITORY_URL -DpomFile=$POM_PATH \
        -Dfile="${LIB_PATH}.aar"



fi

echo "::Upload completed::"