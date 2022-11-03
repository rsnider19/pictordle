words=("CIGAR" "REBUT" "SISSY" "HUMPH" "AWAKE" "BLUSH" "FOCAL" "EVADE" "NAVAL" "SERVE" "HEATH" "DWARF" "MODEL" "KARMA" "STINK" "GRADE" "QUIET" "BENCH" "ABATE" "FEIGN" "MAJOR" "DEATH" "FRESH" "CRUST" "STOOL" "COLON" "ABASE" "MARRY" "REACT" "BATTY" "PRIDE" "FLOSS" "HELIX" "CROAK" "STAFF" "PAPER" "UNFED" "WHELP" "TRAWL" "OUTDO" "ADOBE" "CRAZY" "SOWER" "REPAY" "DIGIT" "CRATE" "CLUCK" "SPIKE" "MIMIC" "POUND" "MAXIM" "LINEN" "UNMET" "FLESH" "BOOBY" "FORTH" "FIRST" "STAND" "BELLY" "IVORY" "SEEDY" "PRINT" "YEARN" "DRAIN" "BRIBE" "STOUT" "PANEL" "CRASS" "FLUME" "OFFAL" "AGREE" "ERROR" "SWIRL" "ARGUE" "BLEED" "DELTA" "FLICK" "TOTEM" "WOOER" "FRONT" "SHRUB" "PARRY" "BIOME" "LAPEL" "START" "GREET" "GONER" "GOLEM" "LUSTY" "LOOPY" "ROUND" "AUDIT" "LYING" "GAMMA" "LABOR" "ISLET" "CIVIC" "FORGE" "CORNY" "MOULT")

for word in "${words[@]}"; do
  curl 'https://backend.craiyon.com/generate' \
    -H 'authority: backend.craiyon.com' \
    -H 'accept: application/json' \
    -H 'accept-language: en-US,en;q=0.9' \
    -H 'content-type: application/json' \
    -H 'origin: https://www.craiyon.com' \
    -H 'sec-ch-ua: "Chromium";v="104", " Not A;Brand";v="99", "Google Chrome";v="104"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"' \
    -H 'sec-fetch-dest: empty' \
    -H 'sec-fetch-mode: cors' \
    -H 'sec-fetch-site: same-site' \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36' \
    --data-raw "{\"prompt\":\"photo realistic $word\"}" \
    --compressed \
    --output "$word.json";

    sleep 5;
done
