# distelli-deploy-branch

Deploy a specified branch to [distelli](http://distelli.com), if it's the current branch.

### optional

* `branch` - The branch you would like deployed.  default: `master`.
* `distelli_app` - The distelli app you would like to deploy.  default: `$DISTELLI_APP`
* `distelli_env` - The distelli environment to deploy to.  defaults: `$DISTELL_ENV`
* `release_id` - The distelli release ID to release.  defaults to existing release for current $WERCKER_GIT_COMMIT.

