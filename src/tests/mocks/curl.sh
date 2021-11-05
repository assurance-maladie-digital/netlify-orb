# Mock curl function to return commit message
function curl() {
    # The command will be called with these parameters:
    # -H "$ACCEPT" "$URL"
    ACCEPT=$2
    URL=$3

    echo '{ "commit": { "message": "Commit message" } }'
}
