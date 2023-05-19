cd /mc 
chmod -R 777 /mc
if [ ! -e "/mc/eula.txt" ]; then
  cp /res/* /mc
fi
echo running args: $(cat /mc/args.txt)
java $(cat /mc/args.txt) -jar server.jar nogui