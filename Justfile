raw:
  #!/usr/bin/env bash
  set -euxo pipefail
  [ -d cards/raw ] || exit 1
  lpr cards/raw/portrait-raw.card \
    -o MediaType=stationery-heavyweight \
    -o InputSlot=manual \
    -o print-quality=5 \
    -o media=3x5

  lpr cards/raw/landscape-raw.card \
    -o MediaType=stationery-heavyweight \
    -o InputSlot=manual \
    -o print-quality=5 \
    -o media=3x5 \
    -o orientation-requested=5

over:
  #!/usr/bin/env bash
  set -euxo pipefail
  [ -f cards/over.card ] || exit 1
  lpr over.card \
    -o media=3x5 \
    -o sides=two-sided-long-edge \
    -o print-quality=5 \
    -o InputSlot=manual \
    -o MediaType=stationery-heavyweight \

pretty:
  #!/usr/bin/env bash
  set -euxo pipefail
  [ -d cards/pretty ] || exit 1

  lpr cards/pretty/landscape-pretty.card \
    -o MediaType=stationery-heavyweight \
    -o InputSlot=manual \
    -o print-quality=5 \
    -o media=3x5 \
    -o prettyprint \
    -o orientation-requested=5

  lpr cards/pretty/portrait-pretty.card \
    -o MediaType=stationery-heavyweight \
    -o InputSlot=manual \
    -o print-quality=5 \
    -o media=3x5 \
    -o prettyprint
