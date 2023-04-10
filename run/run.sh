cd /mc 
if [ ! -e "/mc/server.properties" ]; then
  cp /res/* /mc
fi
echo running args: $(cat /mc/args.txt)
java $(cat /mc/args.txt) -jar mohist.jar nogui