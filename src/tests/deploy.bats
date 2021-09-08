# Runs prior to every test
setup() {
    source ./src/tests/mocks/curl.sh
    source ./src/tests/mocks/netlify.sh
    source ./src/scripts/deploy.sh
}

@test '1: Deploys to Netlify' {
    export CIRCLE_PULL_REQUEST="https://github.com/test/example/pull/0000"
    export CIRCLE_PROJECT_USERNAME="test"
    export CIRCLE_PROJECT_REPONAME="test"
    export CIRCLE_SHA1="example"
    export CIRCLE_BRANCH="feature"

    export PROD="false"

    result=$(echo $(Deploy)|tr -d '\n')

    # Validate the body
    [ "$result" == '{}' ]
}

@test '1: Deploys in production mode to Netlify' {}
