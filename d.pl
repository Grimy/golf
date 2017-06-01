#!perl -pl
s/d/q(+~~rand($')+d)x$`/e;$_=eval
