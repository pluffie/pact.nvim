<div align="center">
<img src="pact.png" style="width: 100%" alt="pact.nvim logo"/>
</div>

# `pact`

> **pact** *[pakt]*
>
> An agreement, covenant, or compact.

`pact` is a *semver focused*, *pessimistic* plugin manager for Neovim.

<div align="center">
<img src="https://user-images.githubusercontent.com/866010/205425753-7a68dfb1-66b5-4c5d-ae16-8ffbca648657.gif"
     style="width: 100%"
     alt="pact.nvim demo"/>
</div>

## Install

To automatically install `pact`,

```lua
-- in your init.lua
local pact_path = vim.fn.stdpath('data') .. '/site/pack/pact/start/pact.nvim'
if vim.fn.empty(vim.fn.glob(pact_path)) > 0 then
  print("Could not find pact.nvim, cloning new copy to", pact_path)
  vim.fn.system({
    'git',
    'clone',
    '--depth', '1',
    '--branch', 'v0.0.2',
    'https://github.com/rktjmp/pact.nvim',
    pact_path
  })
  vim.cmd("helptags " .. pact_path .. "/doc")
end
```

And somewhere in your configuration,

```lua
local pact = require("pact")
local github = pact.github

github("rktjmp/pact.nvim", ">= 0.0.0")
```

Then run `:Pact` to open `pact` (and probably update `pact`).

## Making Pacts

`pact` currently provides the following forge shortcuts:

- `github`
- `gitlab`
- `sourcehut` (alias: `srht`)

As well as the agnostic `git` function.

```fennel
(let [{: github} (require :pact)]
  ;; versions can be given as a raw string
  (github :rktjmp/hotpot.nvim "~ 0.5.0") ;; version constraint
  ;; or you can specify branch, tag, version or commit in a table
  (gitlab :ggandor/lightspeed.nvim {:branch :main})
  ;; raw-git currently requires a unique name
  (git :https://tpope.io/vim/fugitive.git {:name :fugitive :tag :v3.7}))
```

Running the command `:Pact` will open the `pact` interface, which is losely
familar to `fugitive`. It's usage is detailed at the bottom of the buffer.

You may also open `pact` in your own (non-split) window by passing `win` and
`buf` options to `open`.

```fennel
(let [{: open} (require :pact)]
  (open {:win 0 :buf 0
         ;; concurrency-limit defaults to 5 to avoid remote rate limiting
         :concurrency-limit 10}))
```

## Limitations

- **`pact` only suports unix systems.**
- `pact` uses git tags to detect plugin versions. Remote repositories must
  correctly tag their releases with as either `v<major>.<minor>.<patch>` or
  `<major>.<minor>.<patch>`, [partial versioning is not
  supported](https://semver.org/#spec-item-2) (i.e `<major>.<minor>`).
- Pinned `commit`s must be given in full, as we are unable to fetch or remotely
  inspect partial hashes.
- `pact` can not guess a repositories "primary branch" (i.e `main` or
  `master`), you must explicitly define it when pinning to a branch.

## TODO

Expect things to mostly improve, sometimes change.

[https://github.com/rktjmp/pact.nvim/issues/1](https://github.com/rktjmp/pact.nvim/issues/1)

## Articles, clauses, privisos

Pact makes the following assumptions:

- semver versions are tagged in the package repo
  - tags are either "vn.n.n" or "n.n.n"
  - version can be any of `>`, `>=`, `=`, `<`, `<=`, `^` and `~`.
  - Ranges and boolean operations are not supported.
  - Pre-release versions (the `alpha` in `v1.2.3-alpha`) are not currently supported.
  - Should be given as `<operator> <version>` or `<operator><version`.

## See Also

- [paq-nvim](https://github.com/savq/paq-nvim), used as a reference for a tiny,
  no-fuss package manager.
