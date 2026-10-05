# mitex2typst

Converts a Typst file that uses the [MiTeX](https://typst.community/p/mitex) package
(`#mi(...)` / `#mitex(...)`) into plain Typst, replacing every call with native
Typst math. The LaTeX → Typst conversion is done by the
[tylax](https://crates.io/crates/tylax) crate.

- `#mi(`...`)` (inline math) becomes `$<typst math>$`.
- `#mitex(``` ... ```)` (block math) becomes

  ```text
  $
    <typst math>
  $
  ```

  with the `$` lines at the call's indentation and the math indented two extra
  spaces (same style as the manually converted `Discussion 02.typ`).

## Usage

```
mitex2typst <input.typ> [output.typ]
```

If `output.typ` is omitted, the result is written next to the input with a
`.converted` suffix (e.g. `Discussion 3.typ` → `Discussion 3.converted.typ`).

Build: `cargo build --release`, then use `target/release/mitex2typst`.
A VS Code task ("Convert MiTeX to Typst math (current .typ file)") runs it on
the active `.typ` file — see `.vscode/tasks.json`.

## Behavior notes

- Commented-out calls (`// #mi(...)`, `// #mitex(``` ... ```)`) are left
  untouched.
- The ```` ```latex ```` info-string variant of the raw code block is accepted.
- Calls that cannot be parsed (extra arguments, malformed blocks) or that
  `tylax` fails to convert are left in place, with a warning on stderr.
- `tylax` output quality varies: some constructs (e.g. commas inside `\frac`,
  `\lvert\langle...\rangle\rvert`) currently come out as broken Typst math.
  The tool does not fix those — compile the result with Typst and repair the
  flagged lines manually.
