# Vack

**Vack** is the package manager and build tool for the [Lys](https://github.com/safaid-yuragi/lys) programming language.

> Vand Package Manager

Vack is intended to become the main project-management tool for Lys, while the `lys` command remains focused on compilation itself.

```text
Vack
  │
  │ project / package / dependency management
  ↓
Lys
  │
  │ compilation and language semantics
  ↓
Astronomy IR
  │
  ↓
Backend
```

## Status

Vack is currently in the very early bootstrap stage.

The current implementation is intentionally small and is being written in **Lys itself**.

The initial goal is not to implement a complete package ecosystem immediately, but to build enough tooling to manage and build real Lys projects while dogfooding the language and its standard library.

## Goals

Vack is planned to eventually provide:

- project creation and management
- build orchestration
- dependency management
- reproducible lockfiles
- build profiles
- incremental builds and caching
- `run`, `test`, and related development commands
- package publishing and registry support
- target-aware and cross-platform builds

The compiler itself remains separate.

```sh
lys compile [options] <file>
```

Vack will orchestrate calls to the compiler rather than duplicate compiler functionality.

## Bootstrap

Vack is written in Lys.

For now, use:

```sh
./bootstrap.sh build
```

The bootstrap script builds the current Vack executable and places the launcher/binary under:

```text
bin/vack
```

The exact bootstrap process may change while Lys and Vack are still under active development.

## Repository Layout

```text
.
├── README.md
├── bin/
│   └── vack
├── bootstrap.sh
└── src/
    └── main.lys
```

- `src/` — Vack source code written in Lys
- `bin/` — locally bootstrapped Vack executable / launcher
- `bootstrap.sh` — temporary bootstrap procedure

As Vack grows, the source tree will be split by responsibility rather than concentrated into a single large source file.

## Design

Vack is intentionally separate from the Lys compiler.

The long-term toolchain is expected to look roughly like this:

```text
Vack
  ↓
lys compile
  ↓
Astronomy IR
  ↓
target backend
  ↓
object / executable
```

This keeps package management, language semantics, intermediate representation, and machine-specific code generation as separate layers.

## Planned CLI

The exact interface is not stable yet, but Vack is expected to grow toward commands such as:

```sh
vack new hello
vack build
vack run
vack test

vack add <package>
vack remove <package>
vack update
```

These commands are not necessarily implemented yet.

## Why write Vack in Lys?

Vack is also intended to serve as a real-world test of Lys.

Building a package manager requires practical support for things such as:

```text
file I/O
process execution
paths
environment variables
networking
serialization
hashing
error handling
resource management
```

Implementing Vack in Lys helps exercise these parts of the language and standard library under realistic conditions.

## Name

`Vack` comes from **Vand Package Manager**.

The name follows the accidental naming theme around Lys — `lys` means *light* and `vand` means *water* in Danish.

## License

Vack is licensed under BSD 2-Clause License.
See [LICENSE](./LICENSE) file

