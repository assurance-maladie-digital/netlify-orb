# Runs prior to every test
setup() {
    source ./src/tests/mocks/netlify.sh
    source ./src/scripts/deploy.sh
}

@test '1: Deploys to Netlify' {}

@test '1: Deploys in production mode to Netlify' {}
