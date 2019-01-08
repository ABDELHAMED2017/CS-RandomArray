angulars = dlmread('data_file\result_angular.out');
Y = angulars - [0,angulars(:,1:end-1)];
plot(angulars,Y,'m-p');
xlabel('Angle');  %xÖá×ø±êÃèÊö
ylabel('Width of each angle bin'); %yÖá×ø±êÃèÊö