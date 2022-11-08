
echo "#########################################################"
echo "#                                                       #"
echo "#                 Clean all dependencies                #"
echo "#                                                       #"
echo "#########################################################"
echo ""
cd core
flutter clean

cd ..
flutter clean

echo "[INFO] All dependencies cleansing done"