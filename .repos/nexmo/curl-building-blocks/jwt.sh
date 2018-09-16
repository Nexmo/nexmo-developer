# Do we have the Nexmo CLI installed?
command -v nexmo >/dev/null 2>&1 || { echo >&2 "The Nexmo CLI is not installed"; exit 1; }

# Can we load the private key?
if [ ! -f "$NEXMO_PRIVATE_KEY" ]; then
    echo "Could not load private key"
    exit 1
fi

# Do we have an application ID?
if [ -z "$NEXMO_APPLICATION_ID" ]; then
    echo "Application ID not provided"
    exit 1
fi

# Is there an ACL to use?
ACL=""

# Generate the JWT
JWT="$(nexmo jwt:generate $NEXMO_PRIVATE_KEY application_id=$NEXMO_APPLICATION_ID)"

