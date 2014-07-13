wp-site
==============

Simple WordPress site

Configuration
=============

This repo uses Berkshelf[1] to pull in dependencies.
To install berkshelf:

    gem install berkshelf

Usage
=====

Create the cookbook collection using Berkshelf:

    berks vendor cookbooks
    
Create the cookbook collection, to be run in an OpsWorks environment:

    berks vendor cookbooks --except=opsworks_builtin

Create the artifact (a tar archive):

    tar cfz cookbooks.tar.gz cookbooks

Upload the artifact to S3 (this is the S3 location specified in the OpsWorks stack settings for the custom cookbook):

    aws --region us-west-2 s3 cp cookbooks.tar.gz s3://up.shlomoswidler.com/cookbooks.tar.gz
    
The corresponding S3 location for the cookbook tarball would be `https://s3-us-west-2.amazonaws.com/up.shlomoswidler.com/cookbooks.tar.gz`

To clean the cookbook bundle (so you can recreate the bundle from scratch (getting updated cookbooks from their sources)),
do this:

    rm -rf cookbook* Berksfile.lock

Then continue with the `berks vendor cookbooks` command above.

[1]: http://berkshelf.com/

