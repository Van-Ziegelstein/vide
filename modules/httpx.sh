# ---= scan for web servers among all found ips/ports =---
printf "$OP${IN}identifying web servers from $BD$CANDIDATES$RST$IN candidates$RST\n"
$HTTPX -l "$CANDIDATES_FILE" -ec -nf -H "$SCAN_HEADER" \
                            -x ALL -ldp -ec -nfs -server -probe -title -sc -cl -websocket \
                            -silent -stats -threads "$THREADS" -rate-limit "$RATE_LIMIT" -o "$HTTPX_LOG"
grep -v "31mFAILED.*0m" "$HTTPX_LOG" | grep . | cut -d' ' -f1 | sort -u -V > "$WS_FILE"

grep "https" $WS_FILE > $HTTPS_SERVERS
grep -v "https" $WS_FILE  > $HTTP_SERVERS

TARGETS_FILE=$WS_FILE

if [[ -n $HTTP_ONLY ]]; then
    TARGETS_FILE=$HTTP_SERVERS
fi

if [[ -n $HTTPS_ONLY ]]; then
    TARGETS_FILE=$HTTPS_SERVERS
fi


NUM_WS=$(wc -l "$TARGETS_FILE" | cut -d' ' -f1)
if [ "$NUM_WS" == "0" ]; then
    printf "${EP}no web servers found.\n"
    exit 1
fi

printf "$OP${IN}found $BD$NUM_WS$RST$IN web servers$RST\n"
echo -e $BD
cat "$TARGETS_FILE"
echo -e $RST