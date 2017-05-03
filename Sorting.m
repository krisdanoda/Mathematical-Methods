cd('C:\Users\Kristofer Pedersen\Documents\MATLAB\DAY11\')
addpath('C:\Users\Kristofer Pedersen\Documents\MATLAB\DAY11', 'C:\Users\Kristofer Pedersen\Documents\MATLAB\DAY11\elastisk deformation', 'C:\Users\Kristofer Pedersen\Documents\MATLAB\DAY11\GNET')
coordinates = readtable('COORDINATES.txt')

coordinates = coordinates(:,[1 2 4])
East = [];
North = [];
Up = [];

t = 0
for i = 1:height(coordinates)

  filename = cell2mat(strcat( coordinates{i,3}, '_UEN.txt'))

if fopen(filename)~=-1

 East(1,i) = LSQ_fit_line_annual(4,filename)
 North(1,i) = LSQ_fit_line_annual(6,filename)
 Up(1,i) = LSQ_fit_line_annual(2,filename)
else
t = t+1
end





end

%%

for i = 1:height(coordinates)

    Dable{i,1} = East(i)
    Dable{i,2} = North(i)
    Dable{i,3} = Up(i)
    Dable{i,4} = coordinates{i,1}
    Dable{i,5} = coordinates{i,2}
    Dable{i,6} = cell2mat(coordinates{i,3})
end


