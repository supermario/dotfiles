
ln -s `pwd`/config.cson ~/.atom/config.cson
ln -s `pwd`/haskell-format /usr/local/bin/haskell-format

# @TODO Ideal logic pseudocode
# check if file exists
#   it's a symlink
#     it's the same symlink
#       all is well
#     it's different symlink
#       wtf?
#
#   it's a file
#     diff is same
#       replace with symlink?
#         yes -> ok
#         no -> bail
#
#     diff is diff
#       show color diff
#         what do?
#
#   it doesn't exist
#     create the symlink
#
