#!/usr/bin/env bash
# Claude Code status line. Needs bash and jq.
# Row 1: your skills, green when on. Row 2: 5 h and 7 d usage limits. Row 3: model, effort, context use.
# Edit ALWAYS and ON_USE, or set STATUSLINE_ALWAYS and STATUSLINE_ON_USE. A skill that is not installed is not shown.
ALWAYS="${STATUSLINE_ALWAYS-yagni ooga-bogga asd-ste100}"   # on while the skill file exists and settings.json does not switch it off
ON_USE="${STATUSLINE_ON_USE-ui-ux audit-repo audit-ui}"            # grey until this session invokes the skill, then green

command -v jq >/dev/null 2>&1 || { echo "statusline: install jq"; exit 0; }
in=$(cat)
cfg="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
tp=$(jq -r '.transcript_path // ""' <<<"$in")

state=""
for n in $ALWAYS; do
  [ -f "$cfg/skills/$n/SKILL.md" ] || continue   # not installed: not shown
  if [ -f "$cfg/skills/$n/SKILL.md" ] && ! { [ -f "$cfg/settings.json" ] && jq -e --arg n "$n" '.skillOverrides[$n] == "off"' "$cfg/settings.json" >/dev/null 2>&1; }; then
    state+="$n=on "; else state+="$n=off "; fi
done
for n in $ON_USE; do
  [ -f "$cfg/skills/$n/SKILL.md" ] || continue
  if [ -f "$tp" ] && command grep -qm1 -E "\"skill\": ?\"$n\"" "$tp"; then state+="$n=used "; else state+="$n=idle "; fi
done

jq -r --arg state "$state" '
  def c(code; s): "\u001b[\(code)m\(s)\u001b[0m";
  def sep: c("2"; " │ ");
  def col(p): if p >= 85 then "1;31" elif p >= 60 then "1;33" else "1;32" end;
  def bar(p): ([((p / 100 * 6) | round), 6] | min) as $n
    | c(col(p); ([range($n)] | map("█") | join(""))) + c("2"; ([range(6 - $n)] | map("░") | join("")));
  def left(t): (t - now | floor | if . < 0 then 0 else . end) as $s
    | ($s/86400|floor) as $d | ($s%86400/3600|floor) as $h | ($s%3600/60|floor) as $m
    | if $d > 0 then "\($d)d\($h)h" elif $h > 0 then "\($h)h\($m)m" else "\($m)m" end;
  def lim(name; x): if x then
      (x.used_percentage|round) as $p
      | "\(c("1;36"; name)) \(bar($p)) \(c(col($p); "\($p)%")) \(c("38;5;183"; left(x.resets_at)))"
    else empty end;
  def k(n): if n >= 1000000 then "\(n/100000|floor/10)M" elif n >= 1000 then "\(n/1000|round)k" else "\(n)" end;
  def ctx(x): if x and x.used_percentage then
      (x.used_percentage|round) as $p
      | "\(c("1;36"; "ctx")) \(bar($p)) \(c(col($p); "\($p)%")) \(c("38;5;183"; "\(k(x.total_input_tokens // 0))/\(k(x.context_window_size // 0))"))"
    else empty end;
  def dot(s): if s == "on" or s == "used" then c("1;32"; "●") elif s == "off" then c("1;31"; "●") else c("2"; "●") end;
  ($state | split(" ") | map(select(. != "") | split("=")) | map(c("1;36"; .[0] | ascii_upcase) + " " + dot(.[1])) | join(sep) | select(. != "")),
  ([lim("5h"; .rate_limits.five_hour), lim("7d"; .rate_limits.seven_day)] | join(sep) | select(. != "")),
  ([c("1;36"; .model.display_name // "Claude") + (if .effort.level then " " + c("1;32"; .effort.level) else "" end), ctx(.context_window)] | join(sep))
' <<<"$in"
