#!/bin/sh

# Get USER_ID and GROUP_ID from environment variables, default to 1000 if not set
USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}

# Don't allow running as root (UID 0) for security reasons
if [ "$USER_ID" = "0" ]; then
    echo "ERROR: Running as root (UID 0) is not allowed for security reasons."
    echo "Please specify a non-root USER_ID and GROUP_ID when running the container."
    echo "Example: docker run -e USER_ID=1000 -e GROUP_ID=1000 ..."
    exit 1
fi

# Add group with specified ID (if it doesn't exist)
if ! getent group $GROUP_ID > /dev/null 2>&1; then
    addgroup -g $GROUP_ID -S mcuser
else
    # Find group name for existing group
    MC_GROUP=$(getent group $GROUP_ID | cut -d: -f1)
    if [ "$MC_GROUP" != "mcuser" ]; then
        # If the existing group isn't named mcuser, just use the existing group
        :
    fi
fi

# Add user with specified ID (if it doesn't exist)
if ! id -u $USER_ID > /dev/null 2>&1; then
    # Check if group already exists by ID
    if getent group $GROUP_ID > /dev/null 2>&1; then
        MC_GROUP=$(getent group $GROUP_ID | cut -d: -f1)
        adduser -u $USER_ID -S mcuser -G $MC_GROUP -h /home/mcuser -s /bin/sh
    else
        addgroup -g $GROUP_ID -S mcuser
        adduser -u $USER_ID -S mcuser -G mcuser -h /home/mcuser -s /bin/sh
    fi
else
    # User already exists, use its name
    MC_USER=$(id -nu $USER_ID)
    if [ "$MC_USER" != "mcuser" ]; then
        # If the existing user isn't named mcuser, just continue with the existing user
        MC_USER=$MC_USER
    else
        MC_USER="mcuser"
    fi
fi

# Ensure the /mc directory is owned by the target user
chown -R $USER_ID:$GROUP_ID /mc

# Check if /mc directory is empty (first run with volume mount)
if [ -z "$(ls -A /mc)" ]; then
    echo "Initializing /mc directory with Forge server files..."
    # Copy all files from the original location to /mc
    cp -r /original_files/* /mc/
fi

# Ensure the /mc directory is owned by the target user
chown -R $USER_ID:$GROUP_ID /mc

# Run the server script as the target user
if id -u $USER_ID > /dev/null 2>&1; then
    MC_USER=$(id -nu $USER_ID)
else
    MC_USER="mcuser"
fi

# Check if run.sh exists, if not try to run the server jar directly
if [ -f /mc/run.sh ]; then
    exec su -p $MC_USER -c "cd /mc && sh /mc/run.sh"
else
    echo "run.sh not found, attempting to start server directly..."
    # Find the forge server jar file and attempt to start it directly
    SERVER_JAR=$(find /mc -name "forge-*-server.jar" -type f | head -n 1)
    if [ -n "$SERVER_JAR" ]; then
        exec su -p $MC_USER -c "cd /mc && java -jar $SERVER_JAR nogui"
    else
        # Try to find forge server jar in common locations
        SERVER_JAR=$(find /mc/libraries -name "forge-*-server.jar" -type f | head -n 1)
        if [ -n "$SERVER_JAR" ]; then
            exec su -p $MC_USER -c "cd /mc && java -jar $SERVER_JAR nogui"
        else
            echo "ERROR: Could not find run.sh or forge server JAR file."
            echo "Make sure the container is initialized properly with the necessary files."
            exit 1
        fi
    fi
fi