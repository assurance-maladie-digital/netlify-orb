# Runs prior to every test
setup() {
    source ./src/tests/mocks/curl.sh
    source ./src/tests/mocks/netlify.sh
    source ./src/scripts/deploy.sh
}

export PULL_REQUEST_ID="0000"
export CIRCLE_PULL_REQUEST="https://github.com/test/example/pull/${PULL_REQUEST_ID}"
export CIRCLE_PROJECT_USERNAME="test"
export CIRCLE_PROJECT_REPONAME="test"
export CIRCLE_SHA1="example"

export FOLDER="dist/"
export DEBUG="true"

MESSAGE="'Commit message (#$PULL_REQUEST_ID)'"
COMMON_DATA='"message": "--message='"$MESSAGE"'", "site_name": "test", "deploy_id": "id"'
LOGS='"logs": "https://example.com/deploys/id"'

@test '1: Deploys to Netlify' {
    export CIRCLE_BRANCH="feature"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')

    [ "$result" == '{ "dir": "--dir='"$FOLDER"'", '"$COMMON_DATA"', "deploy_url": "https://example.com/id", '"$LOGS"' }' ]
}

@test '2: Deploys to Netlify on dev mode' {
    export CIRCLE_BRANCH="dev"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')

    [ "$result" == '{ "dir": "--dir='"$FOLDER"'", '"$COMMON_DATA"', "deploy_url": "https://dev--example.com", '"$LOGS"' }' ]
}

@test '3: Deploys to Netlify with a custom alias' {
    export CIRCLE_BRANCH="dev" # A custom alias overrides the default behavior
    export ALIAS="rct"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')

    [ "$result" == '{ "dir": "--dir='"$FOLDER"'", '"$COMMON_DATA"', "deploy_url": "https://rct--example.com", '"$LOGS"' }' ]
}

@test '4: Deploys to Netlify in production mode' {
    export CIRCLE_BRANCH="main"
    export PROD="true"

    result=$(echo $(Deploy)|tr -d '\n')

    [ "$result" == '{ "dir": "--dir='"$FOLDER"'", '"$COMMON_DATA"', "deploy_url": "https://example.com", '"$LOGS"' }' ]
}
