# AsciiDoc Converter release notes

## 1.0.0 (2026-10-20)

First release: AsciiDoc to self-contained HTML5, HTML body, DocBook 5 or Markdown with Asciidoctor.js 4.1.1 in SAFE mode; folder/zip projects with includes and images, live preview, attributes panel, highlight.js, embedded Font Awesome and MathJax SVG math, diagnostics with file:line. No network access.

## 1.0.1 (2026-10-20)

Fix STEM literal delimiters in code/configuration; remove Google Fonts import; never truncate pasted text; redact project temp paths; warn about remote media in exports; open archive diagnostic sources in the editor. Upload limit is 64 MiB including multipart framing.

## 1.0.2 (2026-10-20)

The CLI no longer rewrites document text when the document folder path is short (Q:\docs, /work): {docdir} and {docfile} are relative before conversion and only diagnostics have absolute project paths removed. Opening an included file from a diagnostic keeps the preview on the main document.
