#!/usr/bin/env bash
# Installs these skills for DeepSeek Harness (dsh).
# - yagni, ooga-bogga and asd-ste100 go into $DSH_HOME/AGENTS.md, so every session loads them.
#   dsh has no "always load" switch for a skill; its global AGENTS.md reaches every session.
# - ui-ux, audit-repo and audit-ui go into $DSH_HOME/skills. dsh loads ui-ux when a task matches
#   its description. The audit skills carry `disable-model-invocation: true`: only /audit-repo and /audit-ui load them.
# Run it again after an update. It replaces only its own block in AGENTS.md.
set -euo pipefail

src="$(cd "$(dirname "$0")/.." && pwd)"
home="${DSH_HOME:-$HOME/.dsh}"
home="${home/#\~/$HOME}"
always=(yagni ooga-bogga asd-ste100)
on_demand=(ui-ux audit-repo audit-ui)
begin="<!-- spizganed/skills: begin -->"
end="<!-- spizganed/skills: end -->"

mkdir -p "$home/skills"

for s in "${on_demand[@]}"; do
  rm -rf "${home:?}/skills/$s"
  cp -r "$src/$s" "$home/skills/$s"
done

block="$(mktemp)"
trap 'rm -f "$block"' EXIT
{
  echo "$begin"
  echo "# Always-on skills"
  echo
  echo "Follow these rules in every session. They come from github.com/spizganed/skills."
  for s in "${always[@]}"; do
    echo
    echo "## Skill: $s"
    # The body only: drop the YAML frontmatter between the first two '---' lines.
    awk 'n<2 && /^---$/ {n++; next} n>=2' "$src/$s/SKILL.md"
  done
  echo "$end"
} > "$block"

agents="$home/AGENTS.md"
touch "$agents"
# Keep everything outside our markers, then append the fresh block.
awk -v b="$begin" -v e="$end" '$0==b {skip=1} !skip {print} $0==e {skip=0}' "$agents" > "$agents.tmp"
sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$agents.tmp"
{ [ -s "$agents.tmp" ] && { cat "$agents.tmp"; echo; }; cat "$block"; } > "$agents"
rm -f "$agents.tmp"

echo "Always on (in $agents): ${always[*]}"
echo "On demand (in $home/skills): ${on_demand[*]}"
