$DEOB_PATH = "deob-1.2.9-SNAPSHOT-jar-with-dependencies.jar"
$JAV_CONFIG = "jav_config.ws"
$VANILLA = "vanilla.jar"

echo ">>> Starting..."
echo "  > Downloading: $JAV_CONFIG"
curl oldschool.runescape.com/jav_config.ws > $JAV_CONFIG

$BASEURL=select-string $JAV_CONFIG -pattern "codebase" | Select-Object -ExpandProperty Line
$BASEURL = $BASEURL.split('=')[1]
echo "  > Base URL used: $BASEURL"

$INITIAL_JAR=select-string $JAV_CONFIG -pattern "initial_jar" | Select-Object -ExpandProperty Line
$INITIAL_JAR = $INITIAL_JAR.split('=')[1]
echo "  > Initial JAR file for download: $INITIAL_JAR"

$JAR_URL=$BASEURL + $INITIAL_JAR
echo "  > Downloading: $JAR_URL"

wget $JAR_URL -O $VANILLA
echo "  > Download successful"

$command = 'java -cp $DEOB_PATH net.runelite.deob.clientver.ClientVersionMain $VANILLA'
$VANILLA_VER = iex $command
echo "  > OSRS cache version: $VANILLA_VER"
echo ">>> Finished."
