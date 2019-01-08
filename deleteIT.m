% num_antenna = 81;
% angular = [0,90];
% vectors = complex(zeros(num_antenna,2));
% for k = 1:2
%     for t = 1:num_antenna
%         vectors(t,k) = exp(1i*pi*(t-1)*cos(angular(k)*pi/180))/num_antenna;
%     end
% end
% t = vectors(:,1)'*vectors(:,2)
% sqrt(t'*t)        

x = [3 2 1 2 8;...
    5 4 3 8 2;...
    7 8 4 9 7];
 x = x./sqrt(sum(x.^2,1));

y =9*x(:,5);
OMP(x,y,1)