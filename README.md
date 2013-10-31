wp-site
==============

Simple WordPress site

Configuration
=============

This repo uses Berkshelf to pull in dependencies.
To install berkshelf:

    gem install berkshelf

Usage
=====

Create the cookbook collection using Berkshelf:

    berks install --path cookbooks --except=opsworks_builtin

Create the artifact (a tar archive):

    tar cvfz cookbooks.tar.gz cookbooks

Upload the artifact to S3 (this is the S3 location specified in the OpsWorks stack settings for the custom cookbook):

    aws --region us-west-2 s3 cp cookbooks.tar.gz s3://up.shlomoswidler.com/cookbooks.tar.gz
    
The corresponding S3 location for the cookbook tarball would be `https://s3-us-west-2.amazonaws.com/up.shlomoswidler.com/cookbooks.tar.gz`

### Note
For some reason there is [a bug][2] in Berkshelf that prevents it from ignoring the cookbooks in the `--except` specification. The result is that the cookbook collection will contain cookbooks that duplicate OpsWorks built-in cookbooks. However, this should not matter, since the duplicates in this bundle will not be visible because OpsWorks puts its own in the path first.

[1]: http://berkshelf.com/
[2]: https://github.com/RiotGames/vagrant-berkshelf/issues/114
