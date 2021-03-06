﻿texpreamble("\usepackage{CJK}
\AtBeginDocument{\begin{CJK*}{GBK}{song}}
\AtEndDocument{\clearpage\end{CJK*}}");

defaultpen(fontsize(10pt));

struct bb {
    public pair min,max;
    public pair bot, top, left, right;
    static bb bb(pair min, pair max) {
        bb b=new bb;
        b.min=min;
        b.max=max;
        real mx=0.5(min.x+max.x), my=0.5(min.y+max.y);
        b.bot=(mx,min.y);
        b.top=(mx,max.y);
        b.left=(min.x,my);
        b.right=(max.x,my);
        return b;
    }
};

real x=1.5cm, y=0.5cm, z=3cm;

bb box(picture pic=currentpicture, Label L="", pair position=0) {
    label(pic, L, position);
    guide g=(-x, -y)--(x,-y)--(x,y)--(-x,y)--cycle;
    transform t=shift(position);
    draw(pic, t*g);
    return bb.bb(t*(-x,-y), t*(x,y));
}

bb diamond(picture pic=currentpicture, Label L="", pair position=0) {
    label(pic, L, position);
    guide g=(-x,0)--(0,-y)--(x,0)--(0,y)--cycle;
    transform t=shift(position);
    draw(pic, t*g);
    return bb.bb(t*(-x,-y), t*(x,y));
}

bb circle(picture pic=currentpicture, Label L="", pair position=0) {
    label(pic, L, position);
    real m=min(x,y);
    guide g=(-m,0)..(0,-m)..(m,0)..(0,m)..cycle;
    transform t=shift(position);
    draw(pic, t*g);
    return bb.bb(t*(-m,-m), t*(m,m));
}

bb begin=circle("", (4cm,5cm)), end=circle("", (4cm,-1cm));
bb condition=diamond("\tt bool 表达式", (4cm,3cm));
bb body=box("循环体", (4cm,1cm));

pair way(pair a, pair b, real frac) {
    return frac*(b-a)+a;
}

draw(begin.bot--condition.top, MidArrow);
draw("\tt true", condition.bot--body.top, E, MidArrow);

pair body_end=way(body.bot,end.top,1/3), begin_cond=way(begin.bot,condition.top,0.5);
draw(body.bot--body_end--(body_end+z)--(begin_cond+z)--begin_cond, MidArrow);

body_end=way(body.bot, end.top,2/3);
draw("\tt false",condition.left--condition.left-z+x, N);
draw(condition.left-z+x--body_end-z--body_end--end.top, Arrow(position=0.5));
