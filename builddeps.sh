
echo "#########################################################"
echo "#                                                       #"
echo "#                 Upload aar                            #"
echo "#                                                       #"
echo "#########################################################"

./cleandeps.sh

./syncdeps.sh

rm .android/build.gradle
cp upload/project/build.gradle .android

rm .android/Flutter/build.gradle
cp upload/flutter/build.gradle .android/Flutter

rm .android/app/build.gradle
cp upload/app/build.gradle .android/app

rm .android/app/src/main/AndroidManifest.xml
cp upload/AndroidManifest.xml .android/app/src/main

cp upload/google-services.json .android/app

cp -r upload/xml .android/app/src/main/res

flutter build aar --build-number 0.0.1

cp filteringdeps.sh build/host/outputs/repo

echo "[INFO] Moved file done"