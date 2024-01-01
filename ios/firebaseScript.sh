if [ "$CONFIGURATION" == "Debug-residents" ] || [ "$CONFIGURATION" == "Release-residents" ]; then
  cp Runner/residents/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-guards" ] || [ "$CONFIGURATION" == "Release-guards" ]; then
  cp Runner/guards/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi

