unit mouse2;
interface
uses crt,dos,graph;
type cimpcurs=array[0..1,0..15] of word;

const hardflag:boolean=true;
      doubleclicktime:byte=30;
      clickconst=500;
      lbutton:byte=0;
      leftb:byte=0;
      rightb:byte=0;
      bothb:byte=0;
      watchimag=3;
      handimag=2;
      penimag=1;
      arrowimag=5;
      crossimag=6;
      normalimag=0;
      timeimag=7;
      userimag=4;
      hand_cursor:cimpcurs=(
      ($e1ff,$e1ff,$e1ff,$e1ff,$e1ff,$e000,$e000,$e000,
      $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000),
      ($1e00,$1e00,$1e00,$1e00,$1e00,$13ff,$1249,$1249,
      $f249,$9001,$9001,$8001,$8001,$8001,$8001,$ffff));
      pen_cursor:cimpcurs=(
      ($ffff,$c7ff,$c7ff,$83ff,$84ff,$83ff,$83ff,$83ff,
      $83ff,$83ff,$83ff,$ffff,$ffff,$ffff,$ffff,$ffff),
      ($0000,$1000,$1000,$3800,$7c00,$4400,$7c00,$7c00,
      $7c00,$7c00,$7c00,$0000,$0000,$0000,$0000,$0000));
      watch_cursor:cimpcurs=(
      ($ffff,$f83f,$f83f,$f83f,$f01f,$e00f,$c007,$c007,
      $c007,$c007,$c007,$e00f,$f01f,$f83f,$f83f,$f83f),
      ($0000,$0440,$0440,$07c0,$0820,$1110,$2108,$2108,
      $2108,$2208,$2408,$1010,$0820,$07c0,$0440,$0440));
      cross_cursor:cimpcurs=(
      ($ffff,$ffff,$feff,$feff,$feff,$feff,$feff,$ffff,
      $8283,$ffff,$feff,$feff,$feff,$feff,$feff,$ffff),
      ($0000,$0000,$0100,$0100,$0100,$0100,$0100,$0000,
      $7c7c,$0000,$0100,$0100,$0100,$0100,$0100,$0000));
      time_cursor:cimpcurs=(
      ($c003,$e007,$c003,$c003,$e007,$f00f,$f81f,$fc3f,
      $fc3f,$f81f,$f00f,$e007,$c003,$c003,$e007,$c003),
      ($3ffc,$1008,$2004,$2004,$1008,$0810,$0420,$0240,
      $0240,$0420,$0810,$1008,$2004,$2004,$1008,$3ffc));
      arrow_cursor:cimpcurs=(
      ($ffff,$ffbf,$ff1f,$fe0f,$fc0f,$f807,$f007,$fc2f,
      $fc2f,$f87f,$f87f,$f0ff,$f0ff,$e0ff,$ffff,$ffff),
      ($0000,$0000,$0040,$00a0,$0120,$0410,$0e38,$0240,
      $0240,$0480,$0480,$0900,$0900,$1e00,$0000,$0000));

var mousedata1,mousedata2,mousedata3,mousedata4:word;
    user_cursor,actual_cursor:cimpcurs;

    function mouseinstalled:boolean;
    procedure mousereset;
    function mousex:integer;
    function mousey:integer;
    function leftbutton:boolean;
    function rightbutton:boolean;
    function bothbuttons:boolean;
    procedure mousewindow(x1,y1,x2,y2:integer);
    procedure maximizemousewindow;
    procedure mouseimag(x:byte);
    procedure setusercursor(x:cimpcurs);
    function doubleclick(bot:byte):boolean;
    procedure setdoubleclicktime(x:byte);
    procedure mouseon;
    procedure mouseoff;
    procedure mousereinit;

implementation

procedure mouseasm;assembler;
asm
  mov ax,mousedata1
  mov bx,mousedata2
  mov cx,mousedata3
  mov dx,mousedata4
  int $33
  mov mousedata1,ax
  mov mousedata2,bx
  mov mousedata3,cx
  mov mousedata4,dx
end;

procedure lesc;assembler;
asm
  mov ax,seg(actual_cursor);
  mov es,ax;
end;

procedure mouseda(nr:word);
inline($58/$cd/$33);

procedure grafcursor(x:cimpcurs);
begin
  actual_cursor:=x;
  mouseda(2);
  mousedata1:=9;
  mousedata2:=5;
  mousedata3:=0;
  mousedata4:=ofs(actual_cursor);
  lesc;
  mouseasm;
  mouseda(1);
  hardflag:=false;
end;

function grafdriver:integer;
var driver,m:integer;
begin
  driver:=detect;
  detectgraph(driver,m);
  grafdriver:=driver;
end;

procedure mousereinit;
begin
  mouseda(2);
  mousedata1:=0;
  mousedata2:=1;
  mousedata3:=5;
  mousedata4:=8;
  mouseasm;
  mouseda(1);
  hardflag:=true;
end;

procedure mouseorg;
begin
  mouseda(2);
  mouseda(0);
  mouseda(1);
  hardflag:=true;
end;

procedure mousereset;
begin
  if mem[memw[$0000:$00cc+2]:memw[$0000:$00cc]]<>$cf then begin
    mouseda(0);
    mouseda(1);
  end else begin
    writeln('Driver-ul de mouse nu este instalat!!');
    halt(1);
  end;
  mouseorg;
end;

procedure mousedata;
begin
  mousedata1:=3;
  mouseasm;
end;

procedure mousewindow(x1,y1,x2,y2:integer);
begin
  mouseda(2);
  mousedata1:=7;
  mousedata3:=x1;
  mousedata4:=x2;
  mouseasm;
  mousedata1:=8;
  mousedata3:=y1;
  mousedata4:=y2;
  mouseasm;
  mouseda(1);
end;

function doubleclick(bot:byte):boolean;
var s:byte;
    p,b:boolean;
    timp,a1,a2,a3,t,t1:word;
begin
  s:=0;
  p:=false;
  b:=false;
{  gettime(a1,a2,a3,t1);
  t1:=(t1+doubleclicktime) mod 100;}
  timp:=0;
  repeat
    if not p then
      case bot of
        0:b:=leftbutton;
        1:b:=rightbutton;
        2:b:=bothbuttons;
      end;
    if b and not(p) then begin
      inc(s);
      p:=true;
    end;
    if p then
      case bot of
        0:p:=leftbutton;
        1:p:=rightbutton;
        2:p:=bothbuttons;
      end;
  {  gettime(a1,a2,a3,t);}
    inc(timp);
  until (s=2) or {((t>=t1) and (t+doubleclicktime<=100)) or
    ((t<=t1) and (t+doubleclicktime>100))} (timp=doubleclicktime*clickconst);
  doubleclick:=(s=2);
  case bot of
    0:repeat until not leftbutton;
    1:repeat until not rightbutton;
    2:repeat until not bothbuttons;
  end;
end;

procedure setdoubleclicktime(x:byte);
begin
  doubleclicktime:=x;
end;

function mouseinstalled:boolean;
begin
  mouseinstalled:=(mem[memw[$0000:$00cc+2]:memw[$0000:$00cc]]=$cf);
end;

function leftbutton:boolean;
begin
  mousedata1:=3;
  mouseasm;
  leftbutton:=(mousedata2=1) or (mousedata2=3);
end;

function rightbutton:boolean;
begin
  mousedata1:=3;
  mouseasm;
  rightbutton:=(mousedata2=2) or (mousedata2=3);
end;

function bothbuttons:boolean;
begin
  mousedata1:=3;
  mouseasm;
  bothbuttons:=(mousedata2=3);
end;

function mousex:integer;
begin
  mousedata1:=3;
  mouseasm;
  mousex:=mousedata3;
end;

function mousey:integer;
begin
  mousedata1:=3;
  mouseasm;
  mousey:=mousedata4;
end;

procedure setusercursor(x:cimpcurs);
begin
  user_cursor:=x;
end;

procedure mouseimag(x:byte);
begin
  if x=normalimag then mouseorg
  else if x=watchimag then grafcursor(watch_cursor)
  else if x=handimag then grafcursor(hand_cursor)
  else if x=penimag then grafcursor(pen_cursor)
  else if x=userimag then grafcursor(user_cursor)
  else if x=arrowimag then grafcursor(arrow_cursor)
  else if x=crossimag then grafcursor(cross_cursor)
  else if x=timeimag then grafcursor(time_cursor);
end;

procedure mouseon;
begin
  mouseda(1);
end;

procedure mouseoff;
begin
  mouseda(2);
end;

procedure maximizemousewindow;
begin
  mousewindow(0,0,getmaxx,getmaxy);
end;

end.