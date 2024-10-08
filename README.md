# Brother custom-printing

Been wanting to print on 3x5 index cards for a long time.
Turns out Brother supports it with manual feeding.

# `lpr` settings for Brother HL-2460DW

I'd rather print index card documents from the command-line using `lpr`.
Got a list of options with `lpoptions -l`.
Found we print on index cards like so:

```bash
lpr index.card \
  -o media=3x5 \
  -o print-quality=5 \
  -o InputSlot=manual \
  -o MediaType=stationery-heavyweight \
  -p  # -o prettyprint
```

## Paper weight, or `-o mediatype`

Got these printer-specific options with `loptions -l`.
Candidates for the correct `-o mediatype` were:

- stationery-heavyweight (minimal bend)
- com.brother-recycled (worse, excessive bend)
- com.brother-thicker (bad, too much bend)
- envelope-heavyweight (bad, also too much bend)

`stationery-heavyweight` worked best for Staples 3x5 index cards.

# Printing constraints.

By some process[^1], a file gets formatted to be printable when we do:

```bash
cat index.card | lpr
```

Not sure how to select the font, for example, or the size in this pipeline
model.

## Defaults from the justfile

For fuss-free usage, however, we can find constraints of each option.

Run the recipes in the `Justfile`.
List them with `just -l`.
The idea's you can achieve the same results by running the recipes therein listed.

After playing with some text files, I found these values:

| Orientation | Type   | Lines | Columns | Cells         | Recipe        |
| ----------- | ------ | ----- | ------- | ------------- | ------------- |
| Landscape   | Pretty | 18    | 56      | 18\*56 = 1008 | `just pretty` |
| Landscape   | Raw    | 16    | 46      | 16\*46 = 736  | `just raw`    |
| Portrait    | Pretty | 33    | 32      | 33\*32 = 1056 | `just pretty` |
| Portrait    | Raw    | 28    | 26      | 28\*26 = 728  | `just raw`    |

The following are significant consequences of adding `-o prettyprint`:

1. An extra 10 columns in landscape mode.
2. An extra 5 lines in portrait mode.

Funny enough, portrait pretty has the greatest number of cells, making it the
ideal candidate for ASCII art, columnar data, or a perplexing, line-wrapped string.

## Duplex printing?

Nope.
You can run `just over` to see duplex printing on 3x5 index cards doesn't work.
The Brother HL-2460DW doesn't seem to wanna flip index cards.
Tried with both `lpr` and the MacOS Preview app (which sets double-sided by
default).
If anything, I'll have to split the file into chunks depending on the selected
options.
Seems like a good beginner Zig project.

# Footnotes

[^1]: This is exactly where we should start rummaging through the CUPS configuration. Can we select fonts? Customize font-size? Defaults are fine -- but can I change the header? Get some extra real-estate? Etc.
