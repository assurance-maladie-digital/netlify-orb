# Netlify Orb

[![CircleCI Build Status](https://circleci.com/gh/assurance-maladie-digital/netlify-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/assurance-maladie-digital/netlify-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/assurance-maladie-digital/netlify.svg)](https://circleci.com/orbs/registry/orb/assurance-maladie-digital/netlify) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/assurance-maladie-digital/netlify-orb/main/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

This orb provides CircleCI jobs to deploy to Netlify.

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/assurance-maladie-digital/netlify-orb) - The official registry page of this orb for all versions, executors, commands, and jobs described.
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.

### How to Contribute

If your are interested in contributing, you should read the [Code of Conduct](CODE_OF_CONDUCT.md) and the [Contribution Guide](CONTRIBUTING.md).

### How to Publish

* Create and push a branch with your new features.
* When ready to publish a new production version, create a Pull Request from _feature branch_ to `main`.
* The title of the pull request must contain a special semver tag: `[semver:<segment>]` where `<segment>` is replaced by one of the following values.

| Increment | Description|
| ----------| -----------|
| major     | Issue a 1.0.0 incremented release|
| minor     | Issue a x.1.0 incremented release|
| patch     | Issue a x.x.1 incremented release|
| skip      | Do not issue a release|

Example: `[semver:major]`

* Squash and merge. Ensure the semver tag is preserved and entered as a part of the commit message.
* On merge, after manual approval, the orb will automatically be published to the Orb Registry.

For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).
