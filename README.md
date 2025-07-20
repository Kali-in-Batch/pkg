# Forking and cloning the repository

Visit [this](https://codeberg.org/Kali-in-Batch/pkg/fork) to make a fork.

Then, make sure you have installed git from [https://git-scm.com/downloads](https://git-scm.com/downloads).

Copy your fork's URL, then clone it with `git clone <url_you_copied>`

## How to add a new package

You should structure the package directory like this:

```markdown
package-name/
    LICENSE.txt
    README.md
    PREINSTALL <!-- This file is a shell script -->
    rootfs/
        usr/
            bin/
                package-name <!-- This file is also a shell script -->
            lib/
                package-name.lib
            libexec/
                package-name.libexec
            local/
                package-name.local
            share/
                package-name.share
```

You must follow this template in the pull request adding a new package. If you're unsure about which license, see [Choose A License](https://choosealicense.com/licenses/).

You must create a directory called the package name in the packages directory.

Once you have added your package in your fork, you can then make a pull request here to get it added!

## What not to do in your packages

* Do not add malicious code.
* Do not attempt to bypass any security measures.
* Do not include large unnecessary files or binaries that bloat the package.
* Do not violate any software licenses or include proprietary code without permission.
* Do not include sensitive or private information such as passwords, keys, or personal data.
* Do not add broken, untested, or incomplete code that may cause failures.
* Do not add packages that duplicate existing functionality without a clear reason.
* Do not submit packages with unclear, missing, or insufficient documentation.
