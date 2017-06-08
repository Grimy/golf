// c;main(){while(~(c-=c?1:-getchar()))printf(c?";":"#");}
// main(c){while(c-=c>1?1:-getchar())printf(c>1?";":"#");}
// c;main(){while(~(!c?c=getchar():c))printf("#;"+!!--c);}
// c;main(){while(c||~(c=getchar()))puts("#;"+!!--c);}
c;main(){for(;c||~(c=getchar());puts("#;"+!!--c));}
