
Ubuntu Packaging Guide
----------------------

https://wiki.ubuntu.com/PackagingGuide/Complete


----------


**BZR HELP:**

First Choose a suitable root folder: '/home/user/Documents/Application-Projects/gwibber'

Then Get the source code:
apt-get source gwibber

Check whoami first:

    bzr whoami

> if it doesn't return bazzar id then login & set whoami in following
> commands.

Bzr login:
`bzr launchpad-login khurshid-alam` #this doesn't set whoami bcz of this bug: Bug #656645

set whoami manually:

    bzr whoami "Khurshid Alam <khurshid.alam@linuxmail.org>"

> This should be done once

Initialize bzr:

    bzr init

Add everything on root directory: #The directory ur currently in.

    bzr add

Initial Commit:

    bzr commit -m "Initial revision" 

> By supplying commit with the parameter -m you avoid a text editor
> popping up asking you for a commit message.

See the diff:

    bzr diff

Make any changes to files, then commit again.

    bzr diff 
    bzr -commit -m "made small changes in flickr.py"

 

it will show something like this:

    modified Starfire.cs 
    Committed revision 2.

 


Finally Published it to bazzar:

    bzr push lp:~khurshid-alam/gwibber/gwibber-hack/

> When adding new file, bzr add must be done to start tracking on those
> file while staying on root of project dir.Add some new file to folder,
> then run:

    bzr add
    bzr commit -m " add two files"

DONE!

*http://www.emcken.dk/weblog/archives/200-bazaar-bzr-howto-creating-your-own-branch.html*


----------


PPA HELP:
---------

http://askubuntu.com/questions/101763/how-to-upload-theme-files-into-a-ppa

Example : create a new folder. for ex settings-maverick.
Put requires files in it.
Run: (To create necessary under debian.)

    DEBFULLNAME="Khurshid Alam (Technologist)" dh_make -n -s -e khurshid.alam@linuxmail.org 

> This will help to sign the package with gpg key. The id should be
> identical with gpg key id format.to check
> 
> run `gpg --list-keys`. The UID is the proper format. This can also be
> used with `dhbuild -k` option when creating deb package from computer.

https://bugs.launchpad.net/ubuntu/+source/dh-make/+bug/875705

Enter into debian folder & delete .ex & .EX files.

    cd debian
    rm *.ex *.EX

Then run (To upgrade the version number.)

    dch -i

Manually create Install file under debian to ensure which files installs.
Then to deb package run:

    debuild --no-tgz-check


or

    debuild -S

> What the -S flag does is tell debuild to build a source package using
> another script, dpkg-buildpackage, together with fakeroot, which
> grants us fake root privileges while making the package. It will take
> the .orig.tar.gz file and produce a .diff.gz (the difference between
> the original tarball from the author and the directory we have
> created, debian/ and its contents) and a .dsc file that has the
> description and md5sums for the source package. The .dsc and
> *_source.changes (used for uploading the source package) files are signed using your GPG key.


Finally Upload to ppa:

    dput ppa:your-lp-id/ppa <source.changes>

This command upload package & changes to ppa.


**Alternative Guide Example with compiz:**

    sudo apt-get build-dep compiz
    sudo apt-get install devscripts
    wget https://bugs.launchpad.net/ubuntu/+source/compiz/+bug/974242/+attachment/3141645/+files/fix-974242.patch
    apt-get source compiz
    cd compiz* # you might want to replace the *
    patch -p1 < ~/Desktop/fix-974242.patch
    dpkg-source --commit
    debuild -us -uc

**Getting Source from custom ppa:**

    dget -x https://launchpad.net/~moorhen-core/+archive/moorhen-apps/+files/gwibber_3.0.0.1-0ubuntu4.dsc
    
    dpkg-source -x gwibber_3.0.0.1-0ubuntu4.dsc





Private PPA:

https://launchpad.net/~abogani/+archive/e3natty


----------


GIT HELP:
---------


    touch README.md
    git init
    git add READMe.md
    git commit -m "first commit"
    git remote add origin git@github.com:khurshid-alam/milky-moorhen.git
    git push -u origin master

Upload to specific repo Without Password (HTTP):

    git push --repo https://username:password@github.com/khurshid-alam/Codebase.git


Change HTTP To SSH:

    git remote set-url origin git@github.com:username/repo.git

> for ssh public-key paraphrase is used.


----------

Sources:
--------

http://www.vogella.com/articles/Git/article.html


Extra-Tweaks:
http://cheat.errtheblog.com/s/git/

http://github.github.com/github-flavored-markdown/

http://cantina.co/2012/01/16/github-private-git-repos-dropbox/


The Debian package management tools:

Update Software Sources For old releases:
sudo sed -i -e 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list



http://www.debian.org/doc/manuals/debian-faq/ch-pkgtools.en.html








