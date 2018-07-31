![HashiCorp's Terraform](https://cultivatedops-static.s3.amazonaws.com/thirdparty/terraform/logo-50.png)

This repository is a [Terraform](https://terraform.io/) Module for building DC/OS

The module creates aws_instance test and confirm the fix for https://jira.mesosphere.com/browse/COPS-3520

# Usage

```bash
# Pick any branch by changing the ref=<value> below
terraform init -from-module github.com/bernadinm/terraform-dcos-build?ref=master
terraform apply
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| expiration | Paired with Cloud Cluster Cleaner will notify on expiration via slack | string | `4h` | no |
| instance_type |  | string | `m5.xlarge` | no |
| key_name |  | string | `default` | no |
| owner | Paired with Cloud Cluster Cleaner will notify on expiration via slack. Default is whoami. Can be overwritten by setting the value here | string | `mbernadin` | no |
| private_key_path |  | string | `~/.ssh/key.pem` | no |
| user |  | string | `centos` | no |

## Outputs

| Name | Description |
|------|-------------|
| private_ip | # outputs for `resource` # |
| public_ip |  |
| user |  |

## Issue

### Branch: centos | DCOS Version: Master

When building building DC/OS using CentOS, we see that the issue is reproduced.

```bash
ull_resource.build_dcos: Still creating... (1h0m10s elapsed)
null_resource.build_dcos (remote-exec): [INFO]	--> Exporting golang.org/x/sys
null_resource.build_dcos (remote-exec): [INFO]	Replacing existing vendor dependencies
null_resource.build_dcos (remote-exec): [INFO]	Removing nested vendor and Godeps/_workspace directories...
null_resource.build_dcos (remote-exec): [INFO]	Removing: /pkg/src/dcos-cni/vendor/github.com/containernetworking/cni/vendor
null_resource.build_dcos (remote-exec): panic: runtime error: invalid memory address or nil pointer dereference
null_resource.build_dcos (remote-exec): [signal SIGSEGV: segmentation violation code=0x1 addr=0x30 pc=0x6fdc82]

null_resource.build_dcos (remote-exec): goroutine 1 [running]:
null_resource.build_dcos (remote-exec): github.com/Masterminds/glide/path.StripVendor.func1(0xc420278190, 0x4d, 0x0, 0x0, 0x8f3160, 0xc4202c7020, 0x0, 0x0)
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/path/strip.go:28 +0x42
null_resource.build_dcos (remote-exec): path/filepath.walk(0xc4203337c0, 0x42, 0x8fa0e0, 0xc4204a3d40, 0xc4203f6000, 0x0, 0x0)
null_resource.build_dcos (remote-exec): 	/usr/lib/go-1.10/src/path/filepath/path.go:377 +0x20d
null_resource.build_dcos (remote-exec): path/filepath.walk(0xc4201cb440, 0x3b, 0x8fa0e0, 0xc4203612b0, 0xc4203f6000, 0x0, 0x0)
null_resource.build_dcos (remote-exec): 	/usr/lib/go-1.10/src/path/filepath/path.go:381 +0x2c2
null_resource.build_dcos (remote-exec): path/filepath.walk(0xc4201cb380, 0x37, 0x8fa0e0, 0xc4203611e0, 0xc4203f6000, 0x0, 0x0)
null_resource.build_dcos (remote-exec): 	/usr/lib/go-1.10/src/path/filepath/path.go:381 +0x2c2
null_resource.build_dcos (remote-exec): path/filepath.walk(0xc420216420, 0x23, 0x8fa0e0, 0xc420361110, 0xc4203f6000, 0x0, 0x0)
null_resource.build_dcos (remote-exec): 	/usr/lib/go-1.10/src/path/filepath/path.go:381 +0x2c2
null_resource.build_dcos (remote-exec): path/filepath.walk(0xc4202b65c0, 0x18, 0x8fa0e0, 0xc420361040, 0xc4203f6000, 0x0, 0x20)
null_resource.build_dcos (remote-exec): 	/usr/lib/go-1.10/src/path/filepath/path.go:381 +0x2c2
null_resource.build_dcos (remote-exec): path/filepath.Walk(0xc4202b65c0, 0x18, 0xc4203f6000, 0xc420360f70, 0x0)
null_resource.build_dcos (remote-exec): 	/usr/lib/go-1.10/src/path/filepath/path.go:403 +0x106
null_resource.build_dcos (remote-exec): github.com/Masterminds/glide/path.StripVendor(0x8b0354, 0x3b)
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/path/strip.go:22 +0x10a
null_resource.build_dcos (remote-exec): github.com/Masterminds/glide/action.Install(0xc4201d9540, 0x89bc01)
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/action/install.go:62 +0x35b
null_resource.build_dcos (remote-exec): main.commands.func12(0xc420214580, 0x0, 0xc420214580)
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/glide.go:510 +0x2bf
null_resource.build_dcos (remote-exec): github.com/Masterminds/glide/vendor/github.com/codegangsta/cli.HandleAction(0x811280, 0x8ba950, 0xc420214580, 0xc4201ce300, 0x0)
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/vendor/github.com/codegangsta/cli/app.go:490 +0xc8
null_resource.build_dcos (remote-exec): github.com/Masterminds/glide/vendor/github.com/codegangsta/cli.Command.Run(0x899e45, 0x7, 0x8984a0, 0x1, 0x0, 0x0, 0x0, 0x8a58b2, 0x20, 0x0, ...)
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/vendor/github.com/codegangsta/cli/command.go:210 +0xa36
null_resource.build_dcos (remote-exec): github.com/Masterminds/glide/vendor/github.com/codegangsta/cli.(*App).Run(0xc420202000, 0xc42001e090, 0x3, 0x3, 0x0, 0x0)
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/vendor/github.com/codegangsta/cli/app.go:255 +0x6a0
null_resource.build_dcos (remote-exec): main.main()
null_resource.build_dcos (remote-exec): 	/home/vagrant/go/src/github.com/Masterminds/glide/glide.go:104 +0x5a9
null_resource.build_dcos (remote-exec): make: *** [vendor] Error 2
null_resource.build_dcos (remote-exec): Makefile:54: recipe for target 'vendor' failed
null_resource.build_dcos (remote-exec): ERROR: Failure building package(s): docker exited non-zero: 2
null_resource.build_dcos (remote-exec): Command: docker run --name=package-builder-uyblpvjtwl -v /home/centos/dcos/packages/cache/packages/dcos-cni/result:/opt/mesosphere/packages/dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35:rw -v /tmp/pkgpanda-32_khtq_:/opt/mesosphere:ro -v /home/centos/dcos/packages/cache/packages/dcos-cni/src:/pkg/src:rw -v /home/centos/dcos/packages/dcos-cni:/pkg/build:ro -e PKG_PATH=/opt/mesosphere/packages/dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35 -e PKG_VERSION=a9f332f054a1c00ee78b67203fa097b0157b0d35 -e NUM_CORES=4 -e PKG_NAME=dcos-cni -e PKG_VARIANT=<default> -e PKG_ID=dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35 dcos/dcos-builder:dcos-builder_dockerdir-latest /pkg/build/build
null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 1247, in _build
null_resource.build_dcos (remote-exec):     cmd.run("package-builder", command)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 68, in run
null_resource.build_dcos (remote-exec):     check_call(docker)
null_resource.build_dcos (remote-exec):   File "/home/centos/.pyenv/versions/3.5.5/lib/python3.5/subprocess.py", line 271, in check_call
null_resource.build_dcos (remote-exec):     raise CalledProcessError(retcode, cmd)
null_resource.build_dcos (remote-exec): subprocess.CalledProcessError: Command '['docker', 'run', '--name=package-builder-uyblpvjtwl', '-v', '/home/centos/dcos/packages/cache/packages/dcos-cni/result:/opt/mesosphere/packages/dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35:rw', '-v', '/tmp/pkgpanda-32_khtq_:/opt/mesosphere:ro', '-v', '/home/centos/dcos/packages/cache/packages/dcos-cni/src:/pkg/src:rw', '-v', '/home/centos/dcos/packages/dcos-cni:/pkg/build:ro', '-e', 'PKG_PATH=/opt/mesosphere/packages/dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35', '-e', 'PKG_VERSION=a9f332f054a1c00ee78b67203fa097b0157b0d35', '-e', 'NUM_CORES=4', '-e', 'PKG_NAME=dcos-cni', '-e', 'PKG_VARIANT=<default>', '-e', 'PKG_ID=dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35', 'dcos/dcos-builder:dcos-builder_dockerdir-latest', '/pkg/build/build']' returned non-zero exit status 2

null_resource.build_dcos (remote-exec): During handling of the above exception, another exception occurred:

null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/tmp/dcos_build_venv/bin/release", line 11, in <module>
null_resource.build_dcos (remote-exec):     load_entry_point('dcos-image', 'console_scripts', 'release')()
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 937, in main
null_resource.build_dcos (remote-exec):     release_manager.create('testing', options.channel, options.tag, variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 820, in create
null_resource.build_dcos (remote-exec):     self.__config['options']['cloudformation_s3_url'] + '/' + repository_path, tree_variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 328, in make_stable_artifacts
null_resource.build_dcos (remote-exec):     all_completes = do_build_packages(cache_repository_url, tree_variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 578, in do_build_packages
null_resource.build_dcos (remote-exec):     result = pkgpanda.build.build_tree(package_store, True, tree_variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 731, in build_tree
null_resource.build_dcos (remote-exec):     True)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 831, in build
null_resource.build_dcos (remote-exec):     return _build(package_store, name, variant, clean_after_build, recursive)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 1249, in _build
null_resource.build_dcos (remote-exec):     raise BuildError("docker exited non-zero: {}\nCommand: {}".format(ex.returncode, ' '.join(ex.cmd)))
null_resource.build_dcos (remote-exec): pkgpanda.build.BuildError: docker exited non-zero: 2
null_resource.build_dcos (remote-exec): Command: docker run --name=package-builder-uyblpvjtwl -v /home/centos/dcos/packages/cache/packages/dcos-cni/result:/opt/mesosphere/packages/dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35:rw -v /tmp/pkgpanda-32_khtq_:/opt/mesosphere:ro -v /home/centos/dcos/packages/cache/packages/dcos-cni/src:/pkg/src:rw -v /home/centos/dcos/packages/dcos-cni:/pkg/build:ro -e PKG_PATH=/opt/mesosphere/packages/dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35 -e PKG_VERSION=a9f332f054a1c00ee78b67203fa097b0157b0d35 -e NUM_CORES=4 -e PKG_NAME=dcos-cni -e PKG_VARIANT=<default> -e PKG_ID=dcos-cni--a9f332f054a1c00ee78b67203fa097b0157b0d35 dcos/dcos-builder:dcos-builder_dockerdir-latest /pkg/build/build

Error: Error applying plan:

1 error(s) occurred:

* null_resource.build_dcos: error executing "/tmp/terraform_1254185758.sh": Process exited with status 1
```

### Branch: centos_1.11.0 | DCOS Version: 1.11.0 | Commit : <INSERT HERE>

When checking out DC/OS version 1.11.0, we are unable to continue as previously when git was using an old version which did not have the `-C` option. After upgrading the version, we get the next error after this below.

```
null_resource.build_dcos: Still creating... (47m50s elapsed)
null_resource.build_dcos (remote-exec): package-builder-cqpqykvkrr
null_resource.build_dcos (remote-exec): starting: Build package tarball
null_resource.build_dcos (remote-exec): completed: Build package tarball
null_resource.build_dcos (remote-exec): Package built.
null_resource.build_dcos (remote-exec): package-cleaner-dapcvwhzoi
null_resource.build_dcos (remote-exec): completed: Building package python-azure-mgmt-resource variant <default>
null_resource.build_dcos (remote-exec): starting: Building package dcos-image variant <default>
null_resource.build_dcos (remote-exec): Unknown option: -C
null_resource.build_dcos (remote-exec): usage: git [--version] [--help] [-c name=value]
null_resource.build_dcos (remote-exec):            [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
null_resource.build_dcos (remote-exec):            [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
null_resource.build_dcos (remote-exec):            [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
null_resource.build_dcos (remote-exec):            <command> [<args>]
null_resource.build_dcos (remote-exec): ERROR: Failure building package(s): Validation error when fetching sources for package: Unable to check status of git_local_work checkout ../../. Is the rel_path correct?
null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/src_fetchers.py", line 153, in __init__
null_resource.build_dcos (remote-exec):     '-z']).decode()
null_resource.build_dcos (remote-exec):   File "/home/centos/.pyenv/versions/3.5.5/lib/python3.5/subprocess.py", line 316, in check_output
null_resource.build_dcos (remote-exec):     **kwargs).stdout
null_resource.build_dcos (remote-exec):   File "/home/centos/.pyenv/versions/3.5.5/lib/python3.5/subprocess.py", line 398, in run
null_resource.build_dcos (remote-exec):     output=stdout, stderr=stderr)
null_resource.build_dcos (remote-exec): subprocess.CalledProcessError: Command '['git', '-C', '/home/centos/dcos', 'status', '--porcelain', '-uno', '-z']' returned non-zero exit status 129

null_resource.build_dcos (remote-exec): During handling of the above exception, another exception occurred:

null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 113, in get_src_fetcher
null_resource.build_dcos (remote-exec):     return pkgpanda.build.src_fetchers.all_fetchers[kind](**args)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/src_fetchers.py", line 164, in __init__
null_resource.build_dcos (remote-exec):     "rel_path correct?".format(src_info['rel_path']))
null_resource.build_dcos (remote-exec): pkgpanda.exceptions.ValidationError: Unable to check status of git_local_work checkout ../../. Is the rel_path correct?

null_resource.build_dcos (remote-exec): During handling of the above exception, another exception occurred:

null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/tmp/dcos_build_venv/bin/release", line 11, in <module>
null_resource.build_dcos (remote-exec):     load_entry_point('dcos-image', 'console_scripts', 'release')()
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 918, in main
null_resource.build_dcos (remote-exec):     release_manager.create('testing', options.channel, options.tag)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 810, in create
null_resource.build_dcos (remote-exec):     metadata = make_stable_artifacts(self.__config['options']['cloudformation_s3_url'] + '/' + repository_path)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 322, in make_stable_artifacts
null_resource.build_dcos (remote-exec):     all_completes = do_build_packages(cache_repository_url)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 568, in do_build_packages
null_resource.build_dcos (remote-exec):     result = pkgpanda.build.build_tree(package_store, True, None)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 712, in build_tree
null_resource.build_dcos (remote-exec):     True)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 812, in build
null_resource.build_dcos (remote-exec):     return _build(package_store, name, variant, clean_after_build, recursive)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 866, in _build
null_resource.build_dcos (remote-exec):     fetcher = get_src_fetcher(src_info, cache_dir, package_dir)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 115, in get_src_fetcher
null_resource.build_dcos (remote-exec):     raise BuildError("Validation error when fetching sources for package: {}".format(ex))
null_resource.build_dcos (remote-exec): pkgpanda.build.BuildError: Validation error when fetching sources for package: Unable to check status of git_local_work checkout ../../. Is the rel_path correct?

Error: Error applying plan:

1 error(s) occurred:

* null_resource.build_dcos: error executing "/tmp/terraform_490529171.sh": Process exited with status 1
``` 

### Branch: centos_1.11.0 | DCOS Version: 1.11.0

Modifing the setup.py as it was looking for an abstract version of `urllib3`.

```
null_resource.build_dcos (remote-exec): Building package in docker
null_resource.build_dcos: Still creating... (48m30s elapsed)
null_resource.build_dcos (remote-exec): Processing /pkg/src/python-azure-mgmt-resource/azure_mgmt_resource-0.30.0rc4-py2.py3-none-any.whl
null_resource.build_dcos (remote-exec): Installing collected packages: azure-mgmt-resource
null_resource.build_dcos (remote-exec): Successfully installed azure-mgmt-resource-0.30.0rc4
null_resource.build_dcos (remote-exec): package-builder-vxmwckunyp
null_resource.build_dcos (remote-exec): starting: Build package tarball
null_resource.build_dcos (remote-exec): completed: Build package tarball
null_resource.build_dcos (remote-exec): Package built.
null_resource.build_dcos (remote-exec): package-cleaner-onmgtgigvn
null_resource.build_dcos (remote-exec): completed: Building package python-azure-mgmt-resource variant <default>
null_resource.build_dcos (remote-exec): starting: Building package dcos-image variant <default>
null_resource.build_dcos (remote-exec): ERROR: Failure building package(s): Validation error when fetching sources for package: No local changse are allowed in the git_local_work base repository. Use `git -C /home/centos/dcos status` to see local changes. All local changes must be committed or stashed before the package can be built. One workflow (temporary commit): `git -C /home/centos/dcos commit -am TMP` to commit everything, build the package, `git -C /home/centos/dcos reset --soft HEAD^` to get back to where you were.

null_resource.build_dcos (remote-exec): Found changes:  M setup.py
null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 113, in get_src_fetcher
null_resource.build_dcos (remote-exec):     return pkgpanda.build.src_fetchers.all_fetchers[kind](**args)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/src_fetchers.py", line 161, in __init__
null_resource.build_dcos (remote-exec):     "Found changes: {1}".format(self.src_repo_path, git_status))
null_resource.build_dcos (remote-exec): pkgpanda.exceptions.ValidationError: No local changse are allowed in the git_local_work base repository. Use `git -C /home/centos/dcos status` to see local changes. All local changes must be committed or stashed before the package can be built. One workflow (temporary commit): `git -C /home/centos/dcos commit -am TMP` to commit everything, build the package, `git -C /home/centos/dcos reset --soft HEAD^` to get back to where you were.

null_resource.build_dcos (remote-exec): Found changes:  M setup.py

null_resource.build_dcos (remote-exec): During handling of the above exception, another exception occurred:

null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/tmp/dcos_build_venv/bin/release", line 11, in <module>
null_resource.build_dcos (remote-exec):     load_entry_point('dcos-image', 'console_scripts', 'release')()
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 918, in main
null_resource.build_dcos (remote-exec):     release_manager.create('testing', options.channel, options.tag)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 810, in create
null_resource.build_dcos (remote-exec):     metadata = make_stable_artifacts(self.__config['options']['cloudformation_s3_url'] + '/' + repository_path)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 322, in make_stable_artifacts
null_resource.build_dcos (remote-exec):     all_completes = do_build_packages(cache_repository_url)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 568, in do_build_packages
null_resource.build_dcos (remote-exec):     result = pkgpanda.build.build_tree(package_store, True, None)
#!/bin/sh
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 712, in build_tree
null_resource.build_dcos (remote-exec):     True)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 812, in build
null_resource.build_dcos (remote-exec):     return _build(package_store, name, variant, clean_after_build, recursive)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 866, in _build
null_resource.build_dcos (remote-exec):     fetcher = get_src_fetcher(src_info, cache_dir, package_dir)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 115, in get_src_fetcher
null_resource.build_dcos (remote-exec):     raise BuildError("Validation error when fetching sources for package: {}".format(ex))
null_resource.build_dcos (remote-exec): pkgpanda.build.BuildError: Validation error when fetching sources for package: No local changse are allowed in the git_local_work base repository. Use `git -C /home/centos/dcos status` to see local changes. All local changes must be committed or stashed before the package can be built. One workflow (temporary commit): `git -C /home/centos/dcos commit -am TMP` to commit everything, build the package, `git -C /home/centos/dcos reset --soft HEAD^` to get back to where you were.

null_resource.build_dcos (remote-exec): Found changes:  M setup.py

Error: Error applying plan:

1 error(s) occurred:

* null_resource.build_dcos: error executing "/tmp/terraform_735574114.sh": Process exited with status 1
```

### Branch: centos_working

This branch is based on an attepted solution which cannot be built. We will need to dive deper for getting around this since DC/OS doesn't allow local changes when building.

```bash
null_resource.build_dcos: Still creating... (51m40s elapsed)
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-jwt--adee5d66f84d56f2e5d8a22936e9a6307de7ad61
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-certifi--5effb8c5491df70119ca715925097e5881f786b9
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-pyyaml--af2f08036d3a4df955edf0f3d003837b7d17f242
null_resource.build_dcos (remote-exec): Auto-adding dependency: boto--785a6a0209448e13a85177a87d829e3a3892244e
null_resource.build_dcos (remote-exec): Auto-adding dependency: dnspython--78b6b6156205367bdc05ebe6cb9197f6348e3bd9
null_resource.build_dcos (remote-exec): Auto-adding dependency: flask--1ec63b3337e538170ef917c8082ff911f8b752f1
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-docopt--4e1d8cd20908d974ee3bbc553a5b585e9f6c7656
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-jinja2--a0995c0209bb4c7deaac101fcf1d759ffd39d8f3
null_resource.build_dcos (remote-exec): Auto-adding dependency: pytest--26c05bcc4e03e9ba929b1b45a29e809bb1b4ab78
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-retrying--d9bbcfb4248bf5ca305d25d733fdddea2362a5f1
null_resource.build_dcos (remote-exec): Auto-adding dependency: openssl--663447e5841f8f4e7d89bfc538031695de5f47d7
null_resource.build_dcos (remote-exec): Auto-adding dependency: python--2ba17816103010ce6dbbb2e263ade772ad0f73d9
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-requests--677121340afdd1f5e3231229a1054b17a954114f
null_resource.build_dcos (remote-exec): Auto-adding dependency: libffi--74fef627b7b30bd80b0c5c984a59d0ee0f8b8826
null_resource.build_dcos (remote-exec): Auto-adding dependency: python-pycparser--60b5d35583eef7c5e4a0db223d9f4949e0160e9c
null_resource.build_dcos (remote-exec): Downloading source tarball https://pypi.python.org/packages/3b/4d/af3f20257c73a08b4d2bb41d7873c6f5ca806bbc561d3ff335b613ab507c/azure_mgmt_resource-0.30.0rc4-py2.py3-none-any.whl
null_resource.build_dcos (remote-exec): Building package in docker
null_resource.build_dcos (remote-exec): Processing /pkg/src/python-azure-mgmt-resource/azure_mgmt_resource-0.30.0rc4-py2.py3-none-any.whl
null_resource.build_dcos (remote-exec): Installing collected packages: azure-mgmt-resource
null_resource.build_dcos (remote-exec): Successfully installed azure-mgmt-resource-0.30.0rc4
null_resource.build_dcos (remote-exec): package-builder-amprxjotov
null_resource.build_dcos (remote-exec): starting: Build package tarball
null_resource.build_dcos (remote-exec): completed: Build package tarball
null_resource.build_dcos (remote-exec): Package built.
null_resource.build_dcos (remote-exec): package-cleaner-xfjfiriggw
null_resource.build_dcos (remote-exec): completed: Building package python-azure-mgmt-resource variant <default>
null_resource.build_dcos (remote-exec): starting: Building package dcos-image variant <default>
null_resource.build_dcos (remote-exec): ERROR: Failure building package(s): Validation error when fetching sources for package: No local changse are allowed in the git_local_work base repository. Use `git -C /home/centos/dcos status` to see local changes. All local changes must be committed or stashed before the package can be built. One workflow (temporary commit): `git -C /home/centos/dcos commit -am TMP` to commit everything, build the package, `git -C /home/centos/dcos reset --soft HEAD^` to get back to where you were.

null_resource.build_dcos (remote-exec): Found changes:  D packages/dcos-cni/build D packages/dcos-cni/buildinfo.json
null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 122, in get_src_fetcher
null_resource.build_dcos (remote-exec):     return pkgpanda.build.src_fetchers.all_fetchers[kind](**args)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/src_fetchers.py", line 165, in __init__
null_resource.build_dcos (remote-exec):     "Found changes: {1}".format(self.src_repo_path, git_status))
null_resource.build_dcos (remote-exec): pkgpanda.exceptions.ValidationError: No local changse are allowed in the git_local_work base repository. Use `git -C /home/centos/dcos status` to see local changes. All local changes must be committed or stashed before the package can be built. One workflow (temporary commit): `git -C /home/centos/dcos commit -am TMP` to commit everything, build the package, `git -C /home/centos/dcos reset --soft HEAD^` to get back to where you were.

null_resource.build_dcos (remote-exec): Found changes:  D packages/dcos-cni/build D packages/dcos-cni/buildinfo.json

null_resource.build_dcos (remote-exec): During handling of the above exception, another exception occurred:

null_resource.build_dcos (remote-exec): Traceback (most recent call last):
null_resource.build_dcos (remote-exec):   File "/tmp/dcos_build_venv/bin/release", line 11, in <module>
null_resource.build_dcos (remote-exec):     load_entry_point('dcos-image', 'console_scripts', 'release')()
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 937, in main
null_resource.build_dcos (remote-exec):     release_manager.create('testing', options.channel, options.tag, variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 820, in create
null_resource.build_dcos (remote-exec):     self.__config['options']['cloudformation_s3_url'] + '/' + repository_path, tree_variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 328, in make_stable_artifacts
null_resource.build_dcos (remote-exec):     all_completes = do_build_packages(cache_repository_url, tree_variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/release/__init__.py", line 578, in do_build_packages
null_resource.build_dcos (remote-exec):     result = pkgpanda.build.build_tree(package_store, True, tree_variants)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 731, in build_tree
null_resource.build_dcos (remote-exec):     True)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 831, in build
null_resource.build_dcos (remote-exec):     return _build(package_store, name, variant, clean_after_build, recursive)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 885, in _build
null_resource.build_dcos (remote-exec):     fetcher = get_src_fetcher(src_info, cache_dir, package_dir)
null_resource.build_dcos (remote-exec):   File "/home/centos/dcos/pkgpanda/build/__init__.py", line 124, in get_src_fetcher
null_resource.build_dcos (remote-exec):     raise BuildError("Validation error when fetching sources for package: {}".format(ex))
null_resource.build_dcos (remote-exec): pkgpanda.build.BuildError: Validation error when fetching sources for package: No local changse are allowed in the git_local_work base repository. Use `git -C /home/centos/dcos status` to see local changes. All local changes must be committed or stashed before the package can be built. One workflow (temporary commit): `git -C /home/centos/dcos commit -am TMP` to commit everything, build the package, `git -C /home/centos/dcos reset --soft HEAD^` to get back to where you were.

null_resource.build_dcos (remote-exec): Found changes:  D packages/dcos-cni/build D packages/dcos-cni/buildinfo.json
null_resource.build_dcos (remote-exec): ls: cannot access packages/cache/dcos_generate_config.sh: No such file or directory

Error: Error applying plan:

1 error(s) occurred:

* null_resource.build_dcos: error executing "/tmp/terraform_346965092.sh": Process exited with status 2

$ git -C /home/centos/dcos status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	deleted:    packages/dcos-cni/build
	deleted:    packages/dcos-cni/buildinfo.json

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	dcos-release.config.yaml

no changes added to commit (use "git add" and/or "git commit -a")
$
```
