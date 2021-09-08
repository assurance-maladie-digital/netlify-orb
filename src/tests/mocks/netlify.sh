# Mock Netlify CLI to return only the body
function ./node_modules/.bin/netlify() {
    # The command will be called with these parameters:
    # --json --dir=packages/docs/dist [--alias=dev] [--prod] --message='test'
    # ./node_modules/.bin/netlify deploy --json --dir=packages/docs/dist [--alias=dev] [--prod] --message='test'
    echo "test"
}
