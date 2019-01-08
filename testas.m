% load('data_file\result_angular.mat','result_angular');
plot(result_angular(1,2:end),result_angular(1,2:end)-result_angular(1,1:end-1),'m-p');