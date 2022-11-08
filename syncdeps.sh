
echo "#########################################################"
echo "#                                                       #"
echo "#                 Sync all dependencies                 #"
echo "#                                                       #"
echo "#########################################################"
echo ""
cd core
flutter pub get

cd ..
flutter pub get

echo "[INFO] All dependencies sync done"