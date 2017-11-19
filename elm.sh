
# Rudimentary source code spell check. Probably only the since-instance counts are useful.
find src | grep .elm | xargs cat | aspell list | sort | uniq -c | sort -n
