# Mock Netlify CLI to return only the body
function ./node_modules/.bin/netlify() {
    # The command will be called with these parameters:
    # --json --dir="$DIR" --message="$MESSAGE" [--alias="$ALIAS"] [--prod]
    DIR=$3
    MESSAGE=$4
    ALIAS_OR_PROD=$5

    if [ "$ALIAS_OR_PROD" = "--prod" ]; then
        PROD="true"
    else
        ALIAS="${ALIAS_OR_PROD#*=}"
    fi

    # Response from Netily API look like this:
    # { "site_name": "test", "deploy_id": "id", "deploy_url": "https://example.com", "logs": "https://example.com/deploys/id" }
    # We'll add $DIR and $MESSAGE for assertions

    response=(
        '"dir": "'"$DIR"'",'
        '"message": "'"$MESSAGE"'",'
        '"site_name": "test",'
        '"deploy_id": "id"',
    )

    if [ "$PROD" = true ]; then
        response+=( '"deploy_url": "https://example.com",' )
    elif [ -n "$ALIAS" ]; then
        response+=( '"deploy_url": "https://'"$ALIAS"'--example.com",' )
    else
        response+=( '"deploy_url": "https://example.com/id",' )
    fi

    response+=( '"logs": "https://example.com/deploys/id"' )

    echo "{ ${response[@]} }"
}
