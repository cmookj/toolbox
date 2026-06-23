# ------------------------------------------------------------------------------
#   For metapost
# ------------------------------------------------------------------------------
function create_file_mp {
    cat >"$1.mp" <<EOF
prologues := 3;
% outputtemplate := "%j-%c.mps";
% outputformat := "eps";

beginfig(1)
  transform t; t=identity rotated -90 scaled 17pt;

  def line(expr i,j,ii,jj) =
    draw ((i,j)--(ii,jj)) transformed t;
  enddef;

  def black(expr i,j) =
    fill ((i,j)--(i+1,j)--(i+1,j+1)--(i,j+1)--cycle) transformed t;
  enddef;

  line (1,2,1,6); line (2,1,2,7); line (3,1,3,7); line (4,1,4,7);
  line (5,1,5,7); line (6,1,6,7); line (7,2,7,6);
  line (2,1,6,1); line (1,2,7,2); line (1,3,7,3); line (1,4,7,4);
  line (1,5,7,5); line (1,6,7,6); line (2,7,6,7);

  numeric n; n=0;
  for p = (1,2),(1,4),(1,5), (2,1),(2,4),(2,6),
      (3,1),(3,3), (4,3),(4,5), (5,1),(5,2),(5,5), (6,2):
    n:=n+1; label.lrt(decimal n infont "cmr8", p transformed t);
  endfor

  black(2,3); black(3,5); black(4,2); black(5,4);
endfig;

transform pagecoords;
pagecoords:=identity scaled 10mm shifted (100mm,150mm);

beginfig (2)
    fill ((0,0)--(2,0)--(2,1)--(1,1)--(1,2)--(0,2)--cycle)
        transformed pagecoords withcolor green;
    draw ((2,0)..(2,1)..(1,1)..(1,2)..(0,2))
        transformed pagecoords;
    drawarrow ((0,0)--(2,2)) transformed pagecoords;
endfig;

beginfig (3)
    draw (for i=0 upto 7: dir (135i)-- endfor cycle)
        transformed pagecoords;
endfig;

pagecoords:=identity scaled 15mm shifted (100mm,150mm);
beginfig (4);
    % declare paths to be used
    path p[],p[]t;

    % set up points by defining relationships
    z1=(0,0);   z2=z1+2up;
    z3=z1+whatever*dir (60)=z2+whatever*dir (-50);
    z4=z3+(-1.5,-.5);
    z5=z1+dir (135);
    z0=whatever[z1,z2]=whatever[z3,z4];

    % set up paths
    p0=fullcircle yscaled .5 rotated 45 shifted z0 ;
    p1=z2---z4..z0..z3---z1;
    p2=p1 cutbefore p0 cutafter p0;
    p3=p0 cutbefore p1 cutafter p1;
    p4=p2---p3---cycle;

    % define transformed versions of paths and points
    for i=0 upto 4: p[i]t=p[i] transformed pagecoords; endfor
    for i=0 upto 5: z[i]t=z[i] transformed pagecoords; endfor

    % do some drawing
    fill p4t withcolor (1,1,0.2);
    draw z1t---z2t withcolor .5white;
    draw z3t---z4t withcolor .5white;
    pickup pencircle;
    draw p0t dashed withdots scaled .3;
    draw p1t dashed evenly;
    draw p2t withcolor blue;
    draw p3t withcolor red;
    label.lrt (btex \$z_0\$ etex, z0t);
    label.llft (btex \$z_1\$ etex, z1t);
    label.top (btex \$z_2\$ etex, z2t);
    label.rt (btex \$z_3\$ etex, z3t);
    label.llft (btex \$z_4\$ etex, z4t);
    for i=0 upto 4:
        drawdot z[i]t withpen pencircle scaled 2;
    endfor
endfig;

end
EOF
}

function print_metapost_usage {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to create figures"
    echo "--------------------------------------------------------------------------------"
    echo " - Metapost is included in TeX system"
    echo ""
    echo "To generate mps figures"
    echo "    mpost $1"
    echo ""
    echo "To create pdf file use mptopdf command"
    echo "    mptopdf $1"
    echo ""
}

function new_metapost_file {
    echo "Creating a new Metapost file"

    create_file_mp $1

    print_metapost_usage $1
}
