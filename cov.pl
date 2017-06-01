# print/^[^aeiouy]*[aeiouy]*(.)((.)[aeiouy])\2$/&&$3eq$1=~y/bcdfgkpstvz/pgtvkgbzdfs/r
# $a=aeiouy;print/^[^$a]*[$a]+(.)((.)[$a])\2$/&&$3eq$1=~y/bcdfgkpstvz/pgtvkgbzdfs/r
$_=/[aeiouy]+(*COMMIT)(.)((.)[aeiouy])\2$/&&$3eq$1=~y/bcdfgkpstvz/pgtvkgbzdfs/r
