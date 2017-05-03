A=load('greens.txt') ;


x = A(:,1);
y = A(:,2);

xq = 0.6623

plot(A(:,1),A(:,2),'k-*')

Gi = interp1(x,y,xq,'linear')




