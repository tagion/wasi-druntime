# Build tool for wasm D druntime
This in a build script for wasm/wasi for druntime.

The project is build on the work done by [**Sebastiaan Koppe**][https://github.com/skoppe]

The following instruction should be valid for a **debian** based system (**Ubuntu**).

### Installations of wasi-sdk-8.0 ###

The binary can be found [wasi-sdk][https://github.com/WebAssembly/wasi-sdk/releases/tag/wasi-sdk-8] and it can to be installed

```bash
sudo dpkg -i wasi-sdk_8.0_amd64.deb
```

### Building the tool ###

First the submodules needs to be installed

```bash
make subdate
```

The project is build by

```bash
make all
```

**WIP:**







