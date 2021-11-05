#!/bin/sh

Deploy() {
    # Use sed to retreive the PR id after the last /
    # shellcheck disable=SC2001
    PULL_REQUEST_ID=$(echo "$CIRCLE_PULL_REQUEST" | sed 's?.*/??')

    API=https://api.github.com
    USER=$CIRCLE_PROJECT_USERNAME
    REPO=$CIRCLE_PROJECT_REPONAME
    SHA=$CIRCLE_SHA1

    URL=$API/repos/$USER/$REPO/commits/$SHA

    ACCEPT="Accept: application/vnd.github.v3+json"

    COMMIT_MESSAGE=$(curl -H "$ACCEPT" "$URL" | jq -r '.commit.message')

    args=(
        "--json"
        "--dir=$FOLDER"
        "--message='$COMMIT_MESSAGE (#$PULL_REQUEST_ID)'"
    )

    if [ "$PROD" = 1 ]; then
        args+=( "--prod" )
    elif [ -n "$ALIAS" ]; then
        args+=( "--alias=$ALIAS" )
    elif [ "$CIRCLE_BRANCH" = "$MAIN_BRANCH" ]; then
        args+=( "--alias=preprod" )
    elif [ "$CIRCLE_BRANCH" = "$DEV_BRANCH" ]; then
        args+=( "--alias=dev" )
    fi

    if [ "$DEBUG" = true ] && [ "${0#*"$ORB_TEST_ENV"}" = "$0" ]; then
        echo "prod=$PROD;"
        echo "alias=$ALIAS;"
        echo "main_branch=$MAIN_BRANCH;"
        echo "dev_branch=$DEV_BRANCH;"
        echo "${args[@]}"
    fi

    NETLIFY_API_RESPONSE=$(./node_modules/.bin/netlify deploy "${args[@]}")

    if [ "$DEBUG" = true ]; then
        echo "$NETLIFY_API_RESPONSE"
    fi

    if [ "$PROD" = 1 ]; then
        URL_PARAM=".url"
    else
        URL_PARAM=".deploy_url"
    fi

    NETLIFY_DEPLOY_URL=$(echo "$NETLIFY_API_RESPONSE" | jq -r "$URL_PARAM")

    # Export deploy URL for use in other context (eg. GitHub Status Checks)
    echo "export NETLIFY_DEPLOY_URL='$NETLIFY_DEPLOY_URL'" >> "$BASH_ENV"
}

# Will not run if sourced for bats-core tests
# View src/tests for more information
ORB_TEST_ENV="bats-core"
if [ "${0#*"$ORB_TEST_ENV"}" = "$0" ]; then
    Deploy
fi
