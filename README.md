[![build status](https://gitlab.timmertech.nl/docker/alpine-sdk/badges/master/build.svg)](https://gitlab.timmertech.nl/docker/alpine-sdk/commits/master)
[![](https://images.microbadger.com/badges/image/datacore/alpine-sdk.svg)](https://microbadger.com/images/datacore/alpine-sdk)
[![](https://images.microbadger.com/badges/version/datacore/alpine-sdk.svg)](https://microbadger.com/images/datacore/alpine-sdk )
[![](https://images.microbadger.com/badges/commit/datacore/alpine-sdk.svg)](https://microbadger.com/images/datacore/alpine-sdk)
[![](https://images.microbadger.com/badges/license/datacore/alpine-sdk.svg)](https://microbadger.com/images/datacore/alpine-sdk)

# docker/alpine-sdk

Alpine SDK for building packages

# Usage

```bash
docker run --name alpine-sdk --hostname sdk -e GITHUB_USER=<GITHUB_USERNAME> -it gjrtimmer/alpine-sdk sh --login
```
