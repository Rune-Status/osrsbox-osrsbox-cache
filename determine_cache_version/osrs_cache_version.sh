DEOB_PATH="deob-1.2.9-SNAPSHOT-jar-with-dependencies.jar"
JAV_CONFIG="jav_config.ws"
VANILLA="vanilla.jar"

rm $JAV_CONFIG
rm $VANILLA

echo ">>> Starting..."
echo "  > Downloading: $JAV_CONFIG"
wget -q oldschool.runescape.com/jav_config.ws

# Check the file was downloaded sucessfully
if [[ "$?" != 0 ]]; then
    echo ">>> Error downloading file. Exiting."
    exit 1
else
    echo "  > Download sucessful."
fi

# Get the base URL for download
BASEURL=$(grep codebase $JAV_CONFIG | cut -d'=' -f2)
echo "  > Base URL used: $BASEURL"

# Get the JAR file name for download
INITIAL_JAR=$(grep initial_jar $JAV_CONFIG | cut -d'=' -f2)
echo "  > Initial JAR file for download: $INITIAL_JAR"

# Combine base URL and JAR file name
JAR_URL=$BASEURL$INITIAL_JAR

# Download the JAR file
echo "  > Downloading: $JAR_URL"
wget -q $JAR_URL -O $VANILLA

# Check the file was downloaded sucessfully
if [[ "$?" != 0 ]]; then
    echo ">>> Error downloading file. Exiting."
    exit 1
else
    echo "  > Download sucessful."
fi

# Extract the cache version
VANILLA_VER=$(java -cp $DEOB_PATH net.runelite.deob.clientver.ClientVersionMain $VANILLA)
echo "  > OSRS version: $VANILLA_VER"

# Clean up files
if [ -f "$file" ]; 
    rm $JAV_CONFIG
    rm $VANILLA
fi

echo ">>> Finished."