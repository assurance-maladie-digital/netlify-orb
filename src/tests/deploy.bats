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
export DEV_BRANCH="dev"
export MAIN_BRANCH="main"
export DEBUG="true"

GetExpectedResponse() {
    MESSAGE="'Commit message (#$PULL_REQUEST_ID)'"
    COMMON_DATA='"message": "--message='"$MESSAGE"'", "site_name": "test", "deploy_id": "id"'
    LOGS='"logs": "https://example.com/deploys/id"'

    DEPLOY_URL=$1

    echo '{ "dir": "--dir='"$FOLDER"'", '"$COMMON_DATA"', "deploy_url": "'"$DEPLOY_URL"'", '"$LOGS"' }'
}

@test '1: Deploys to Netlify' {
    export CIRCLE_BRANCH="feature"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')
    expected_result=$(GetExpectedResponse "https://example.com/id")

    [ "$result" == "$expected_result" ]
}

@test '2: Deploys to Netlify on dev mode' {
    export CIRCLE_BRANCH="dev"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')
    expected_result=$(GetExpectedResponse "https://dev--example.com")

    [ "$result" == "$expected_result" ]
}

@test '3: Deploys to Netlify on dev mode with a specific branch' {
    export DEV_BRANCH="developement"
    export CIRCLE_BRANCH="developement"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')
    expected_result=$(GetExpectedResponse "https://dev--example.com")

    [ "$result" == "$expected_result" ]
}

@test '4: Deploys to Netlify on preprod mode' {
    export CIRCLE_BRANCH="main"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')
    expected_result=$(GetExpectedResponse "https://preprod--example.com")

    [ "$result" == "$expected_result" ]
}

@test '5: Deploys to Netlify on preprod mode with a specific branch' {
    export MAIN_BRANCH="master"
    export CIRCLE_BRANCH="master"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')
    expected_result=$(GetExpectedResponse "https://preprod--example.com")

    [ "$result" == "$expected_result" ]
}

@test '6: Deploys to Netlify in production mode' {
    export CIRCLE_BRANCH="main"
    export PROD="true"

    result=$(echo $(Deploy)|tr -d '\n')
    expected_result=$(GetExpectedResponse "https://example.com")

    [ "$result" == "$expected_result" ]
}

@test '7: Deploys to Netlify with a custom alias' {
    # A custom alias overrides the default behavior
    export CIRCLE_BRANCH="dev"
    export ALIAS="rct"
    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')
    expected_result=$(GetExpectedResponse "https://rct--example.com")

    [ "$result" == "$expected_result" ]
}
