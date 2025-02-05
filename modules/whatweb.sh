# ---= scan server tech/headers =---
printf "$OP$IN$(basename $BASH_SOURCE) tech scans:$RST\n"
for TARGET in $(grep -v "#" "$TARGETS_FILE" | sort -V); do
    parse $TARGET
    l2 "WhatWeb scan of"
    mkdir -p "$WW_DIR/$FILE_NAME"
    $WW --aggression=$WHATWEB_LEVEL "$TARGET"\
        -U="$SCAN_HEADER" --header="$CUSTOM_HEADER"\
        --log-verbose="$WW_DIR/$FILE_NAME/deep.log"\
        --log-brief="$WW_DIR/$FILE_NAME/brief.log"\
        --max-threads="$THREADS"
    let COUNTER++
    unset {PROTO,IP,PORT,FILE_NAME,DO_SSL}
done
# epilog
for x in brief deep; do find "$WW_DIR" -type f -name "${x}.log" -exec cat {} >>"$WW_DIR/${x}_all.log" +;done
NEW_TARGETS=$(cat "$WW_DIR/deep_all.log"| grep -oP "RedirectLocation\[(.*)\]" | cut -d '[' -f2- | cut -d ']' -f1 | sort -u)
echo $NEW_TARGETS >> $TARGETS_FILE
sed '/^[[:space:]]*$/d' $TARGETS_FILE
sort -u -o $TARGETS_FILE $TARGETS_FILE
COUNTER=1
