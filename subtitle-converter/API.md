# Subtitle Converter API


Start with `--no-open --port 47125`. Multipart examples:
```sh
curl -F file=@captions.srt -F to=vtt -F shift=-500ms http://127.0.0.1:47125/api/convert
curl -F file=@captions.srt http://127.0.0.1:47125/api/inspect
curl -F file=@cd1.srt -F file=@cd2.srt -F offset=52m -F to=srt http://127.0.0.1:47125/api/merge
curl -F file=@captions.srt -F at=52m http://127.0.0.1:47125/api/split
```
Convert returns `{text,filename,format,input_format,encoding,cues,report,summary}`; split returns `{parts:[Result,Result]}`. `text` can replace `file`. Option fields match CLI names with underscores. Inspect returns a decoded preview, candidate encodings, cue count, format and warnings; an inspection parse failure is returned as its `error` field.

For video, `POST /api/upload` with one `file` returns `{id,info,tracks}`. Send that `id` to `/api/extract` with `track,to`, or to `/api/mux` / `/api/burn` alongside subtitles and `container=mkv|mp4`. Mux options: `lang,title,default`; burn: `size,position,margin,crf,box,override`. Video jobs return `{id,name,size}`; download `GET /api/result?id=...`. Release a retained video/result with `POST /api/release` JSON `{"id":"..."}`. Errors use `{error}` with 4xx for invalid input, 503 when busy, 504 at the deadline. `/api/health` stays responsive during processing. Host/origin guards restrict the API to the local tool origin.

Limits: 16 MiB per subtitle/paste, 32 MiB total per web request, 20 merge files, 100,000 cues, 256 KiB per source line and 1 MiB per decoded cue. Decoded text is limited to 48 MiB; output to 64 MiB. Web subtitle jobs have a 30-second deadline and two concurrent slots. Video uploads are limited to 4 GiB, video jobs to three hours and two concurrent slots; CLI accepts larger local videos. Cancellation, client disconnect or server death kills native work. Parent-owned temp folders are removed after jobs; crash leftovers older than an hour are swept on next start. CLI writes are committed by rename after success.

