program FlappyBird_atestat;
uses graph, crt, venbuton, mouse2, dos;
{--------------Realizat de Gavrila Robert-Daniel-----------------}
const
  WIDTH = 640;
  HEIGHT = 480;
  BIRD_SIZE = 20;
  PIPE_WIDTH = 50;
  PIPE_GAP = 150;
  PIPE_SPEED = 4;
  GRAVITY = 0.5;
  JUMP_SPEED = 8;

type
  TPipe = record
    x, y, height: integer;
  end;

var
  gd, gm,size: integer;
  pipes: array[1..3] of TPipe;
  birdX, birdY: integer;
  birdYSpeed:real;
  score,best: integer;
  gameover,sem,sem1,sem2: boolean;
  c: char;
  b1,b2,b3,b4,b5,b6,b10,b11:button;

procedure DrawBird;
var x,y:integer;
begin
  x:=birdX; y:=birdY;
          setcolor(0);
         setlinestyle(solidln,1,normwidth);
       ellipse(x,y,0,360,17,15);
          setfillstyle(solidfill,14);
          fillellipse(x,y,17,15);
       ellipse(x+15,y+5,0,360,8,4);
          setfillstyle(solidfill,12);
          fillellipse(x+15,y+5,8,4);
       line(x+7,y+5,x+23,y+5);
       setfillstyle(solidfill,15);
       ellipse(x+11,y-6,0,360,7,6);
          fillellipse(x+11,y-6,7,6);
       ellipse(x-10,y+6,0,360,9,5);
          setfillstyle(solidfill,6);
          fillellipse(x-10,y+6,9,5);
       setfillstyle(solidfill,0);
       fillellipse(x+13,y-6,1,4);
end;

procedure DrawPipes;
var
  i: integer;
begin
  setcolor(6);
  setfillstyle(solidfill,2);
  for i := 1 to 3 do
  begin
    bar(pipes[i].x, 0, pipes[i].x + PIPE_WIDTH, pipes[i].height);
    bar(pipes[i].x, pipes[i].height + PIPE_GAP, pipes[i].x + PIPE_WIDTH, HEIGHT);
  end;
end;

procedure UpdatePipes;
var
  i: integer;
begin
  for i := 1 to 3 do
  begin
    pipes[i].x := pipes[i].x - PIPE_SPEED;
    if pipes[i].x + PIPE_WIDTH < 0 then
    begin
      if score=0 then score:=score+1;
      pipes[i].x := WIDTH;
      pipes[i].height := random(HEIGHT - PIPE_GAP);
      score:=score+1;
    end;
  end;
end;

procedure CheckCollisions;
var
  i: integer;
begin
  if birdY < 0 then
    gameover := true;
  if birdY + BIRD_SIZE > HEIGHT then
    gameover := true;
  for i := 1 to 3 do
    if (birdX + BIRD_SIZE > pipes[i].x) and (birdX < pipes[i].x + PIPE_WIDTH) and
       ((birdY < pipes[i].height) or (birdY + BIRD_SIZE > pipes[i].height + PIPE_GAP)) then { if the bird hits a pipe  }
      gameover := true;
end;

procedure UpdateBird;
begin
  birdY := birdY + round(birdYSpeed);
  birdYSpeed := birdYSpeed + GRAVITY;
  if keypressed then
     begin
          c := readkey;
          if c = #32 then
          birdYSpeed := -JUMP_SPEED;
     end;
  if leftbutton then birdYSpeed := -JUMP_SPEED;
end;

procedure DrawScore;
var
scoreStr: string;
begin
setcolor(15);
settextstyle(defaultfont,0,3);
str(score, scoreStr);
outtextxy(getmaxx div 2, 40, scoreStr);
settextstyle(defaultfont,0,1);
end;

procedure InitGame;
var
i: integer;
begin
randomize;
gd := detect;
initgraph(gd, gm, '');
birdX := WIDTH div 2;
birdY := HEIGHT div 2;
birdYSpeed := 0;
for i := 1 to 3 do
begin
pipes[i].x := WIDTH + (i - 1) * (WIDTH div 3);
pipes[i].height := random(HEIGHT - PIPE_GAP);
end;
score := 0;
gameover := false;
end;

procedure help;
begin
     sem2:=false;
     mouseoff;
     cleardevice;
     definire_buton(b6,550,440,600,470,15,4,'BACK');
     pune_buton(b6);
     setbkcolor(1);
     setfillstyle(solidfill,2);
     bar(0,15,getmaxx div 2-60,60);
     bar(390,15,getmaxx,60);
     setcolor(15);
     settextstyle(0,0,3);
     outtextxy(getmaxx div 2-40,20,'HELP');
     settextstyle(0,0,1);
     setlinestyle(0,0,3);
     line(getmaxx div 2-40,50,getmaxx div 2+50,50);
     setlinestyle(0,0,1);
     outtextxy(440,5,'(c) Gavrila Daniel, 2023');
     outtextxy(10,100,chr(4)+' Pentru a controla pasarea, trebuie apasata tasta SPACE sau Click-Stanga.');
     outtextxy(10,130,chr(4)+' Pentru a reveni la meniul initial, trebuie apasat butonul cu iconita '+chr(127)+' .');
     outtextxy(10,160,chr(4)+' Pentru a reporni jocul, trebuie apasata tasta ENTER sau apasat butonul cu ');
     outtextxy(23,180,'iconita '+chr(16)+' .');
     outtextxy(10,210,chr(4)+' Pentru a inchide programul, exista doua metode:');
     outtextxy(50,230,chr(4)+' GAME OVER -> BUTON '+chr(127)+' -> EXIT.');
     outtextxy(50,250,chr(4)+' GAME OVER -> Apasati tasta ESC.');
     outtextxy(10,280,chr(4)+' Scorul creste cu un punct in urma trecerii printr-un tunel.');
     outtextxy(10,310,chr(4)+' Pentru a creste fluiditatea jocului, se recomanda crestea numarului de ');
     outtextxy(23,330,' cicluri ale DOSBOX-ului, actionand tastele CTRL+F12 pentru crestere si');
     outtextxy(23,350,' CTRL+F11 pentru scadere.');
     outtextxy(10,380,chr(4)+' Sistemul de medalii se clasifica in functie de scorul obtinut astfel:');
     circle(80,403,7);
     outtextxy(100,400,' - <5 -> Nu se primeste medalie');
     setfillstyle(solidfill,6);
     fillellipse(80,423,7,7);
     outtextxy(100,420,' - [5,15) -> Medalie de bronz');
     setfillstyle(solidfill,7);
     fillellipse(80,443,7,7);
     outtextxy(100,440,' - [15,25) -> Medalie de argint');
     setfillstyle(solidfill,14);
     fillellipse(80,463,7,7);
     outtextxy(100,460,' - >25 -> Medalie de aur');
     birdX:=30; birdY:=35;
     drawbird;
     mouseon;
     if buton_apasat(b6) then sem2:=true;
     repeat until buton_apasat(b6);
     mouseoff;
end;

procedure ecran;
var x,y:integer;
begin
    setbkcolor(0);
    mouseoff;
       x:=getmaxx;
       y:=getmaxy;
       setfillstyle(solidfill,11);
       bar(0,0,x,y);
       setfillstyle(solidfill,6);
       bar(0,y,x,y-50);
       setfillstyle(solidfill,10);
       bar(0,y-50,x,y-60);
    setfillstyle(solidfill,2);
    bar(102,0,152,250);      {I}
    bar(102,y-60,152,350);
    bar(294,0,344,120);        {II}
    bar(294,y-60,344,330);
    bar(486,0,536,150);           {III}
    bar(486,y-60,536,250);
    buton(b1,250,200,380,230,15,1,'PLAY');
    pune_buton(b1);
    buton(b2,250,240,380,270,15,1,'HELP');
    pune_buton(b2);
    buton(b3,250,280,380,310,15,1,'EXIT');
    pune_buton(b3);
    settextstyle(0,0,1);
    setcolor(1);
    settextstyle(0,0,6);
    outtextxy(50,50,'FLAPPY BIRD');
    setcolor(1);
    settextstyle(0,0,1);
    setcolor(15);
    outtextxy(430,465,'(c)  Daniel Gavrila, 2023');
    birdx:=320;
    birdy:=150;
    drawbird;


end;

procedure sfscreen;
var s,s1:string;
begin
    setfillstyle(solidfill,3);
bar(140,180,470,320);
settextstyle(0,0,5);
outtextxy(130,100, 'GAME OVER');
settextstyle(0,0,2);
setcolor(6);
outtextxy(170,200,'MEDALIE');
outtextxy(370,200,'SCOR');
outtextxy(370,260,'BEST');
setcolor(15);
if score>=best then best:=score;
str(score,s);
str(best,s1);
settextstyle(0,0,3);
outtextxy(390,225,s);
setcolor(4);
outtextxy(390,285,s1);
settextstyle(0,0,1);
setcolor(0);
if score<5 then
   begin
        setfillstyle(solidfill,3);
        setcolor(15);
        outtextxy(170,305,'Mai incearca!');
   end;
if (score>=5) and (score<15) then
   begin
        setfillstyle(solidfill,6);
        setcolor(15);
        outtextxy(150,305,'- Medalia de Bronz -');
   end;
if (score>=15) and (score<25) then
   begin
        setfillstyle(solidfill,7);
        setcolor(15);
        outtextxy(150,305,'- Medalia de Argint -');
   end;
if score>=25 then
   begin
        setfillstyle(solidfill,14);
        setcolor(15);
        outtextxy(150,305,'- Medalia de Aur -');
   end;
fillellipse(220,260,35,35);
settextstyle(0,0,3);
    definire_buton(b10,180,350,280,400,15,2,chr(16));
    pune_buton(b10);
    definire_buton(b11,330,350,430,400,15,4,chr(127));
    pune_buton(b11);
settextstyle(0,0,1);
end;

procedure GameLoop;
var s:string;
begin
repeat
cleardevice;
{DrawBackground;}
setbkcolor(0);
DrawPipes;
DrawBird;
DrawScore;
UpdatePipes;
UpdateBird;
CheckCollisions;
delay(35);
if gameover then
begin
sem1:=false;
sfscreen;
repeat
mouseon;
if buton_apasat(b11) then
    begin
         sem:=false;
         ecran;
         sem1:=false;
             repeat
    mouseon;
    If buton_apasat(b1) then
      begin
           sem:=true;
           sem1:=true;
           mouseoff;
           cleardevice;
           gameloop;
      end;
    if buton_apasat(b2) then
       begin
           { sem:=true;}
            cleardevice;
            help;
            gameloop;
       end;
    IF buton_apasat(b3) then
       begin
            sem:=true;
            sem1:=true;
            halt;
       end;
    until sem;
    end;
if buton_apasat(b10) then sem1:=true;
if keypressed then
   begin
        if readkey=#27 then
           begin
                sem1:=true;
                halt;
           end;
        if readkey=#13 then sem1:=true;
   end;
until sem1=true;
InitGame;
end;
until false;
mouseoff;
end;

procedure table;
var i,j,y1,x,y:integer; S1,S2:string;
begin
    sem:=false;  sem2:=false;
    ecran;
    repeat
    mouseon;
    If buton_apasat(b1) then
      begin
           sem:=true;
           mouseoff;
           cleardevice;
           gameloop;
      end;
    if buton_apasat(b2) then
       begin
            mouseon;
            cleardevice;
            help;
            cleardevice;
            table;
       end;
    IF buton_apasat(b3) then
       begin
            sem:=true;
            halt;
       end;
    If (buton_apasat(b6))  and (sem) then
       begin
            sem:=true;
            cleardevice;
            table;
       end;
    until sem;
    mouseoff;
end;

begin
InitGame;
best:=0;
cleardevice;
table;
closegraph;
end.