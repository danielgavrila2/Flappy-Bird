{****************************************************************************}
{*                                                                          *}
{*  VENTURA SOFTWARE                                                        *}
{*  Butoane                                                                 *}
{*  -Made in 1996-                                                          *}
{*                                                                          *}
{****************************************************************************}
unit venbuton;

interface

uses graph,mouse2;

type button=record
      x1,y1,x2,y2  :integer;
      t            :string;
      bcolor,tcolor:integer;
     end;

     procedure definire_buton(var b:button;x1,y1,x2,y2,bcolor,tcolor:integer;text:string);
     procedure pune_buton(b:button);
     procedure pune_buton_apasat(b:button);
     function buton_apasat(bu:button):boolean;
     procedure buton(var b:button;x1,y1,x2,y2,bcolor,tcolor:integer;text:string);

implementation

procedure definire_buton(var b:button;x1,y1,x2,y2,bcolor,tcolor:integer;text:string);
begin
 b.x1    :=x1;
 b.x2    :=x2;
 b.y1    :=y1;
 b.y2    :=y2;
 b.bcolor:=bcolor;
 b.tcolor:=tcolor;
 b.t     :=text;
end;

procedure pune_buton(b:button);
begin
 mouseoff;
 with b do
 begin
  setfillstyle(1,bcolor);
  bar(x1,y1,x2,y2);
  setcolor(0);
  rectangle(x1-1,y1-1,x2+1,y2+1);
  setcolor(15);
  begin
   line(x1,y1,x1,y2);
   line(x1,y1,x2,y1);
  end;
  setcolor(8);
  begin
   line(x2,y1,x2,y2);
   line(x1,y2,x2,y2);
  end;
 { settsextstyle(2,0,4);   }
  setcolor(tcolor);
  outtextxy(x1+1+(x2-x1-textwidth(t)) div 2,y1+(y2-y1-textheight(t)) div 2-2,t);
 end;
 mouseon;
end;

procedure pune_buton_apasat(b:button);
var i:byte;
begin
 mouseoff;
 with b do
 begin
  setfillstyle(1,bcolor);
  bar(x1,y1,x2,y2);
  setcolor(0);
  rectangle(x1-1,y1-1,x2+1,y2+1);
  setcolor(8);
  begin
   line(x1,y1,x1,y2);
   line(x1,y1,x2,y1);
  end;
{  settextstyle(2,0,4); }
  setcolor(tcolor);
  outtextxy(x1+2+(x2-x1-textwidth(t)) div 2,y1+(y2-y1-textheight(t)) div 2-1,t);
 end;
 mouseon;
end;

function buton_apasat(bu:button):boolean;
var a,b:integer;
    sem:boolean;
begin
    a:=mousex;b:=mousey;
    with bu do
    sem:=(leftbutton) and (a>=x1) and (a<=x2) and (b>=y1) and (b<=y2);
    if sem then
     begin
      mouseoff;
      pune_buton_apasat(bu);
      mouseon;
      with bu do
      repeat
      until (not leftbutton) or (mousex<x1)or (mousex>x2) or (mousey<y1)or(mousey>y2);
      a:=mousex;b:=mousey;
      mouseoff;
      pune_buton(bu);
      mouseon;
     end;
    buton_apasat:=sem and (a>=bu.x1) and (a<=bu.x2) and (b>=bu.y1) and (b<=bu.y2);
end;

procedure buton(var b:button;x1,y1,x2,y2,bcolor,tcolor:integer;text:string);
begin
 definire_buton(b,x1,y1,x2,y2,bcolor,tcolor,text);
 pune_buton(b);
end;

end.