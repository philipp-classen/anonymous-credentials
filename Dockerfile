# For deterministic builds, the base image has to be frozen. These
# are the steps that we would like to execute:
#
# # sdk-tag-1.38.27-64bit
# FROM trzeci/emscripten@sha256:14ac3cc8e7aef67d44f51233d8fb4b26b7922c571df27e8645b64d8f11f9fd88
# RUN apt-get update && apt-get install -y python3
#
# (TODO: With this fixed image, the build seems to be reproducible. That is nice, but how
# to can you trust that image? It has been built with Docker Hub, but how can you proof that?)
FROM philippclassen/anonymous-credentials-build@sha256:5c10733dce0bad8b018e6e295dc175d1178781bfbc1004caca3411d94f44db30

RUN mkdir /group-sign
COPY . /group-sign
WORKDIR /group-sign
RUN ./build-emscripten.sh && \
    echo "Build successful. Hashes of the generated artifacts:" && \
    echo && \
    echo "SHA-256 hashes:" && sha256sum /group-sign/dist/group-sign-wasm.js /group-sign/dist/group-sign-asmjs.js && \
    echo && \
    echo "SHA-384 hashes:" && sha384sum /group-sign/dist/group-sign-wasm.js /group-sign/dist/group-sign-asmjs.js && \
    echo && \
    echo "SHA-512 hashes:" && sha512sum /group-sign/dist/group-sign-wasm.js /group-sign/dist/group-sign-asmjs.js
