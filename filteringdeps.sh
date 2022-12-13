if [ "${PWD}" = "/Users/aprikot/Projects/scm_mobile_sdk" ]
then
  echo "[ERROR] Current directory cannot run \"./filterdeps.sh\""
  echo "[ERROR] Run \"cd build/host/outputs/repo\" then run \". /Users/aprikot/Projects/scm_mobile_sdk/filteringdeps.sh\""
else
  if [ "${PWD}" = "/Users/aprikot/Projects/scm_mobile_sdk/build/host/outputs/repo" ]
  then
     echo "#########################################################"
      echo "#                                                       #"
      echo "#           FIND & REMOVE UNUSED FILE                   #"
      echo "#                                                       #"
      echo "#########################################################"

      find . -type f ! \( -name \*.pom -o -name \*.aar -o -name \*.module \) -exec rm "{}" \;

      echo "[INFO] Find & Removed Unused File Done"

      echo "#########################################################"
      echo "#                                                       #"
      echo "#           FIND & REMOVE UNUSED FOLDER                 #"
      echo "#                                                       #"
      echo "#########################################################"

      find . -type d \( -name \*_debug -o -name \*_profile -o -name \*_release \) -exec rm -r "{}" \;

      echo "[INFO] Find & Removed Unused Folder Done"
  else
    echo "[ERROR] Current directory cannot run ./filterdeps.sh"
    echo "[ERROR] Run \"cd build/host/outputs/repo\" then run \"./filterdeps.sh\""
 fi
fi