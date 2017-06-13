# substance-box

Substance base box VM packer & salt scripts.

The images are generated using [https://www.packer.io](Packer).

The actual images are hosted on [https://bintray.com](Bintray).

## How to generate new images

To generate new images, you need [https://www.packer.io](Packer). If Packer
is installed, then you can use the `make` task to generate a new Substance
box version. For example, to generate version 1.16:

```
> make BOX_VERSION=1.16
```

These scripts were tested on Packer version 0.12 on Mac OS X, but they *should*
work on newer versions as well.

## How to upload new images on Bintray

To upload new images on Bintray, you need and API key. Once you have that, use
the `make upload` task command to upload your image. For example, to upload
a new revision of the substance box as version 1.16:

```
> make upload BOX_VERSION=1.16 BINTRAY_USERNAME=turbulent BINTRAY_APIKEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
```

After the upload is done, you must log into Bintray and go to the
`substance-images` repository to publish the artifacts that were just
uploaded. It takes a few minutes for publication to occur, so be patient!

## License

All work found under this repository is licensed under the [Apache
License 2.0](LICENSE).

