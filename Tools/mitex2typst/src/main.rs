//! mitex2typst: replace MiTeX `#mi(...)` / `#mitex(...)` calls in a Typst file
//! with native Typst math.
//!
//! - `#mi(`...`)`            (single-backtick raw string, inline math)
//!   becomes `$<typst math>$`.
//! - `#mitex(``` ... ```)`   (raw code block, block math; an info string such
//!   as `latex` after the opening fence is allowed)
//!   becomes
//!
//!   ```text
//!   $
//!     <typst math>
//!   $
//!   ```
//!
//! with the `$` lines at the same indentation as the original call and the
//! converted math indented two extra spaces (mirroring the style of
//! `Discussion 02.typ`).
//!
//! The LaTeX -> Typst conversion itself is done by the `tylax` crate.
//!
//! Usage: `mitex2typst <input.typ> [output.typ]`
//!
//! When `output.typ` is omitted, it defaults to the input path with a
//! `.converted` suffix, e.g. `Discussion 3.typ` -> `Discussion 3.converted.typ`.

use std::env;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::ExitCode;
use std::sync::Arc;

const MI: &str = "#mi(";
const MITEX: &str = "#mitex(";

fn main() -> ExitCode {
    let args: Vec<String> = env::args().skip(1).collect();
    if args.len() != 1 && args.len() != 2 {
        eprintln!("Usage: mitex2typst <input.typ> [output.typ]");
        eprintln!();
        eprintln!("Replaces MiTeX #mi(...) / #mitex(...) calls in a Typst file with");
        eprintln!("native Typst math (converted with the tylax crate).");
        eprintln!();
        eprintln!("If output.typ is omitted, it defaults to the input path with a");
        eprintln!("\".converted\" suffix (e.g. \"Discussion 3.typ\" -> \"Discussion 3.converted.typ\").");
        return ExitCode::FAILURE;
    }
    let input = PathBuf::from(&args[0]);
    let output = match args.get(1) {
        Some(p) => PathBuf::from(p),
        None => default_output_path(&input),
    };

    let src = match fs::read_to_string(&input) {
        Ok(s) => s,
        Err(e) => {
            eprintln!("error: cannot read {}: {e}", input.display());
            return ExitCode::FAILURE;
        }
    };

    let (out, stats, warnings) = convert(&src);
    for w in &warnings {
        eprintln!("warning: {w} (the original call was left in place)");
    }

    if let Some(parent) = output.parent().filter(|p| !p.as_os_str().is_empty()) {
        if let Err(e) = fs::create_dir_all(parent) {
            eprintln!("error: cannot create directory {}: {e}", parent.display());
            return ExitCode::FAILURE;
        }
    }
    if let Err(e) = fs::write(&output, &out) {
        eprintln!("error: cannot write {}: {e}", output.display());
        return ExitCode::FAILURE;
    }

    println!(
        "{}: replaced {} inline and {} block MiTeX call(s)",
        output.display(),
        stats.inline,
        stats.block
    );
    if stats.inline + stats.block == 0 {
        println!("  (no MiTeX calls found; output is a copy of the input)");
    }
    if !warnings.is_empty() {
        println!("  ({} call(s) could not be converted, see warnings)", warnings.len());
    }
    ExitCode::SUCCESS
}

fn default_output_path(input: &Path) -> PathBuf {
    let name = input
        .file_stem()
        .map(|s| s.to_os_string())
        .unwrap_or_else(|| std::ffi::OsString::from("output"));
    let mut name = name;
    name.push(".converted.typ");
    input.with_file_name(name)
}

#[derive(Default)]
struct Stats {
    inline: usize,
    block: usize,
}

/// Scan `src` for `#mi(` / `#mitex(` calls and replace them with native Typst
/// math. Returns the converted text, counts, and warnings for calls that had
/// to be left untouched.
fn convert(src: &str) -> (String, Stats, Vec<String>) {
    let mut out = String::with_capacity(src.len() * 2);
    let mut stats = Stats::default();
    let mut warnings = Vec::new();
    let mut i = 0usize;

    while i < src.len() {
        let rest = &src[i..];
        let mi = rest.find(MI);
        let mitex = rest.find(MITEX);
        // Neither pattern is a substring of the other, so at most one can be
        // the earlier candidate.
        let (rel, is_mitex) = match (mi, mitex) {
            (Some(a), Some(b)) => {
                if a <= b {
                    (a, false)
                } else {
                    (b, true)
                }
            }
            (Some(a), None) => (a, false),
            (None, Some(b)) => (b, true),
            (None, None) => break,
        };
        let p = i + rel; // absolute position of the `#`
        out.push_str(&src[i..p]);

        if is_mitex {
            i = process_mitex(src, &mut out, p, &mut stats, &mut warnings);
        } else {
            i = process_mi(src, &mut out, p, &mut stats, &mut warnings);
        }
        assert!(i > p, "scan position must advance");
    }
    out.push_str(&src[i..]);
    (out, stats, warnings)
}

/// Process a `#mi(` candidate at absolute position `p` (inline math).
/// Returns the new scan position.
fn process_mi(
    src: &str,
    out: &mut String,
    p: usize,
    stats: &mut Stats,
    warnings: &mut Vec<String>,
) -> usize {
    if is_commented(src, p) {
        out.push_str(MI);
        return p + MI.len();
    }
    let line = line_number(src, p);

    // The first argument must be a single-backtick raw string: `...`
    if src.as_bytes().get(p + MI.len()) != Some(&b'`') {
        warnings.push(format!("line {line}: #mi call does not take a raw string"));
        out.push_str(MI);
        return p + MI.len();
    }
    let open = p + MI.len() + 1; // first byte of the string content
    let close = match find_backtick(src, open) {
        Some(c) => c,
        None => {
            warnings.push(format!("line {line}: unterminated raw string in #mi call"));
            out.push_str(MI);
            return p + MI.len();
        }
    };
    // Expect `)` right after the closing backtick.
    if src.as_bytes().get(close + 1) != Some(&b')') {
        warnings.push(format!(
            "line {line}: #mi call has extra arguments, not supported"
        ));
        out.push_str(&src[p..close + 1]);
        return close + 1;
    }
    let latex = src[open..close].trim();
    match convert_latex(latex, line, "mi") {
        Some(typst) => {
            out.push('$');
            out.push_str(&typst);
            out.push('$');
            stats.inline += 1;
        }
        None => {
            warnings.push(format!("line {line}: failed to convert #mi content `{latex}`"));
            out.push_str(&src[p..close + 2]);
        }
    }
    close + 2
}

/// Process a `#mitex(` candidate at absolute position `p` (block math).
/// Returns the new scan position.
fn process_mitex(
    src: &str,
    out: &mut String,
    p: usize,
    stats: &mut Stats,
    warnings: &mut Vec<String>,
) -> usize {
    if is_commented(src, p) {
        out.push_str(MITEX);
        return p + MITEX.len();
    }
    let line = line_number(src, p);

    // The first argument must be a raw code block: ``` ... ```
    let mut k = p + MITEX.len();
    while matches!(src.as_bytes().get(k), Some(b' ') | Some(b'\t')) {
        k += 1;
    }
    let fence_len = count_backticks(src, k);
    if fence_len < 3 {
        warnings.push(format!(
            "line {line}: #mitex call does not take a raw code block"
        ));
        out.push_str(MITEX);
        return p + MITEX.len();
    }
    let after_open = k + fence_len;
    let indent = leading_whitespace(src, p);

    let (content, end) = match parse_block(src, after_open) {
        Some(v) => v,
        None => {
            warnings.push(format!(
                "line {line}: malformed or unterminated raw code block in #mitex call"
            ));
            out.push_str(MITEX);
            return p + MITEX.len();
        }
    };
    match convert_latex(&content, line, "mitex") {
        Some(typst) => {
            emit_block(out, &indent, &typst);
            stats.block += 1;
            end
        }
        None => {
            warnings.push(format!(
                "line {line}: failed to convert #mitex block, left in place"
            ));
            out.push_str(&src[p..end]);
            end
        }
    }
}

/// Parse a raw code block whose opening fence ends at `after_open`.
///
/// Returns (LaTeX content, position just past the closing `)`). The content is
/// the text between the opening line and the closing fence line, with the
/// common leading indentation removed. The closing `)` right after the fence
/// is required.
fn parse_block(src: &str, after_open: usize) -> Option<(String, usize)> {
    let line_end = src[after_open..]
        .find('\n')
        .map(|n| after_open + n)
        .unwrap_or(src.len());

    // Single-line form: #mitex(```x + y```)
    if let Some((frel, flen)) = find_fence(src, after_open, line_end) {
        let content = src[after_open..after_open + frel].trim().to_string();
        let after_fence = after_open + frel + flen;
        let end = expect_close_paren(src, after_fence)?;
        return Some((content, end));
    }

    // Multi-line form: the block ends at the first line whose (trimmed)
    // content starts with a fence of 3+ backticks.
    let body_start = line_end + 1;
    let (rel, flen) = find_closing_fence_line(src, body_start)?;
    let fence_line_start = body_start + rel;
    let end = expect_close_paren(src, fence_line_start + flen)?;

    // The content includes the trailing newline before the fence line.
    let raw = src[body_start..fence_line_start].to_string();
    Some((strip_common_indent(&raw), end))
}

/// Skip whitespace after a closing fence and require a `)`.
/// Returns the position just past the `)`.
fn expect_close_paren(src: &str, after_fence: usize) -> Option<usize> {
    let mut j = after_fence;
    while matches!(
        src.as_bytes().get(j),
        Some(b' ') | Some(b'\t') | Some(b'\r')
    ) {
        j += 1;
    }
    if src.as_bytes().get(j) == Some(&b')') {
        Some(j + 1)
    } else {
        None
    }
}

/// Emit block math. The leading whitespace of the original call line has
/// already been copied to `out` by the scanner, so the opening `$` is written
/// without an extra indent:
///
/// ```text
/// <indent>$
/// <indent>  <math line 1>
/// <indent>  <math line 2>
/// ...
/// <indent>$
/// ```
fn emit_block(out: &mut String, indent: &str, typst_math: &str) {
    out.push('$');
    out.push('\n');
    for line in typst_math.lines() {
        if line.trim().is_empty() {
            out.push('\n');
        } else {
            out.push_str(indent);
            out.push_str("  ");
            out.push_str(line);
            out.push('\n');
        }
    }
    out.push_str(indent);
    out.push('$');
}

/// Convert a LaTeX math string to Typst math with `tylax`.
/// Returns `None` if the conversion failed (caller leaves the original in place).
fn convert_latex(latex: &str, line: usize, what: &str) -> Option<String> {
    if latex.is_empty() {
        return None;
    }
    let latex = Arc::from(latex);
    let result = std::panic::catch_unwind(|| tylax::latex_to_typst(&latex));
    match result {
        Ok(typst) => {
            let typst = typst.trim().to_string();
            if typst.is_empty() {
                eprintln!(
                    "note: line {line}: tylax produced no output for {what} content"
                );
                None
            } else {
                Some(typst)
            }
        }
        Err(_) => {
            eprintln!("note: line {line}: tylax panicked on {what} content");
            None
        }
    }
}

// ---------------------------------------------------------------------------
// Small scanning helpers (byte-oriented; the file is expected to be UTF-8 text)
// ---------------------------------------------------------------------------

/// True if there is a `//` line comment earlier on the same line as `pos`
/// (a `://` sequence, e.g. in a URL, does not count).
fn is_commented(src: &str, pos: usize) -> bool {
    let line_start = src[..pos].rfind('\n').map(|i| i + 1).unwrap_or(0);
    let bytes = src[line_start..pos].as_bytes();
    let mut i = 0usize;
    while i + 1 < bytes.len() {
        if bytes[i] == b'/' && bytes[i + 1] == b'/' {
            if i > 0 && bytes[i - 1] == b':' {
                i += 2; // "://" in a URL
                continue;
            }
            return true;
        }
        i += 1;
    }
    false
}

fn line_number(src: &str, pos: usize) -> usize {
    src[..pos].bytes().filter(|&b| b == b'\n').count() + 1
}

/// The leading whitespace of the line containing `pos`.
fn leading_whitespace(src: &str, pos: usize) -> String {
    let line_start = src[..pos].rfind('\n').map(|i| i + 1).unwrap_or(0);
    let mut s = String::new();
    for c in src[line_start..].chars() {
        if c == ' ' || c == '\t' {
            s.push(c);
        } else {
            break;
        }
    }
    s
}

fn find_backtick(src: &str, from: usize) -> Option<usize> {
    src[from..].find('`').map(|n| from + n)
}

/// Number of consecutive backticks at position `p` (0 if `src[p]` is not a backtick).
fn count_backticks(src: &str, p: usize) -> usize {
    src.as_bytes()[p..]
        .iter()
        .take_while(|&&b| b == b'`')
        .count()
}

/// Find a run of 3+ backticks within `src[lo..hi)` (the opening line of the
/// raw code block, after the opening fence). Returns (offset from `lo`, length).
fn find_fence(src: &str, lo: usize, hi: usize) -> Option<(usize, usize)> {
    let bytes = src.as_bytes();
    let mut i = lo;
    while i + 2 < hi {
        if bytes[i] == b'`' && bytes[i + 1] == b'`' && bytes[i + 2] == b'`' {
            let len = count_backticks(src, i);
            if len >= 3 {
                return Some((i - lo, len));
            }
        }
        i += 1;
    }
    None
}

/// Find the first line at or after `from` (in bytes) whose trimmed content
/// starts with a run of 3+ backticks (the closing fence of a raw code block).
/// Returns (offset of the first backtick of that fence from `from`, fence length).
fn find_closing_fence_line(src: &str, from: usize) -> Option<(usize, usize)> {
    let mut start = from;
    for line in src[from..].split_inclusive('\n') {
        let trimmed = line.trim_start();
        if trimmed.starts_with("```") {
            let flen = count_backticks(trimmed, 0);
            if flen >= 3 {
                let indent = line.len() - trimmed.len();
                return Some((start + indent - from, flen));
            }
        }
        start += line.len();
    }
    None
}

/// Remove the common leading indentation from all (non-empty) lines.
fn strip_common_indent(s: &str) -> String {
    let common = s
        .lines()
        .filter(|l| !l.trim().is_empty())
        .map(|l| l.len() - l.trim_start().len())
        .min()
        .unwrap_or(0);
    if common == 0 {
        return s.to_string();
    }
    s.lines()
        .map(|l| {
            if l.trim().is_empty() {
                String::new()
            } else {
                l.get(common..).unwrap_or(l).to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n")
}
