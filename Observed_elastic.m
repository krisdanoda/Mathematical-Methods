%%observed_elastic

PGR = ICEPGR5GUEN(:,:)

LSQ = LSQ

'ICEPGR5GUEN'
a=6378137 ;

%%load data file
A=(ICEPGR5GUEN) ;
n = height(A) ;

L=A{:,1}*pi/180 ;     % bredde i grader fra input fil
M=A{:,2}*pi/180 ;     % længde i grader fra input fil
Vns_obs=A{:,3} ;
Vew_obs=A{:,4} ;

whos

% rotation vector  
%MwF= MwP - FwP = (wx, wy, wz)

% rotation pole  
%plat = atan(wz / sqrt (wx*wx+wy*wy)) 
%plon = atan(wy/wx) 

T=-2.299*pi/180   % bredde for euler pol 
P=-85.540*pi/180  % længde for euler pol
% rotations hastighed
w= 0.207*(pi/180)/1000000  % rotations hastighed for euler pol


% rotation rate
%rate = sqrt(wx*wx+wy*wy*+wz*wz) 

% velocity at a point (tlat,tlon) 
for i=1:n
Vns_est(i,1) = a*w*cos(T)*sin(M(i)-P) ;
Vew_est(i,1) = a*w*( cos(L(i))*sin(T) - sin(L(i))*cos(T)*cos(M(i)-P)) ;
end


PGR_PPR = PGR;
PGR_PPR{:, [4 5]} = PGR{:, [4 5]} - [Vew_est, Vns_est];

%% Jummp

for i = 1:height(PGR_PPR)

    for k = 1:height(LSQ)
        if strcmpi(PGR_PPR{i,6},LSQ{k,6})
    EAST(1,i) =  LSQ{k,1} - PGR_PPR{i,4};
    NORTH(1,i) =  LSQ{ k,02 }- PGR_PPR{i,5};
    UP(1,i) = LSQ{k,3} - PGR_PPR{i,3};
   names{1,i} = cell2mat(PGR_PPR{i,6});
        end
        end


end