if [ "$CONFIGURATION" == "Debug-guards" ] || [ "$CONFIGURATION" == "Release-guards" ]; then
  cp Runner/guards/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi

