![HashiCorp's Terraform](https://cultivatedops-static.s3.amazonaws.com/thirdparty/terraform/logo-50.png)

This repository is a [Terraform](https://terraform.io/) Module for building DC/OS

The module creates aws_instance

# Usage

Add the module to your Terraform resources like so:

```
module "terraform-dcos-build" {
  source = "./terraform-module-terraform-dcos-build"
  arg1 = "foo"
}
```

Then, load the module using `terraform get`.


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

