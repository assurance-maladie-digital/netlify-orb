# Runs prior to every test
setup() {
    source ./src/tests/mocks/curl.sh
    source ./src/tests/mocks/netlify.sh
    source ./src/scripts/deploy.sh
}

@test '1: Deploys to Netlify' {
    export PULL_REQUEST_ID="0000"
    export CIRCLE_PULL_REQUEST="https://github.com/test/example/pull/${PULL_REQUEST_ID}"
    export CIRCLE_PROJECT_USERNAME="test"
    export CIRCLE_PROJECT_REPONAME="test"
    export CIRCLE_SHA1="example"
    export CIRCLE_BRANCH="feature"

    export FOLDER="dist/"
    export PROD="false"
    export DEBUG="true"

    result=$(echo $(Deploy)|tr -d '\n')

    # Validate the body
    [ "$result" == '{ "dir": "--dir='"$FOLDER"'", "message": "--message='"'"'Commit message (#'"$PULL_REQUEST_ID"'))'"'"'", "site_name": "test", "deploy_id": "id", "deploy_url": "https://example.com/id", "logs": "https://example.com/deploys/id" }' ]
}

@test '1: Deploys in production mode to Netlify' {
    true;
}
