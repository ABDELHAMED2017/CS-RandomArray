function steering_matrix = RandomArray_simulation(num_antenna,aperture,is_random,recompute)

Model_paras.work_frequency = 3*10^9;
Model_paras.speed_light = 3*10^8;
Model_paras.angulars = get_angulars(0);
Model_paras.ratio_wavelength_antennaSpace = 1/2;
Model_paras.num_antenna = num_antenna;
Model_paras.aperture = aperture;
Model_paras.is_random = is_random;

if ~Model_paras.is_random
    Model_paras.antenna_space = [1:Model_paras.num_antenna-1] * (Model_paras.speed_light / Model_paras.work_frequency * Model_paras.ratio_wavelength_antennaSpace);
else
    Model_paras.antenna_space = get_antennaSpace_random(Model_paras.num_antenna,Model_paras.aperture,0);
end

 
Model_paras.antenna_space = [0,Model_paras.antenna_space];

[steering_matrix,coherence] = get_steering_matrix(Model_paras,recompute);



end

%% 获得角度数组
function result_angular = get_angulars(recompute)
% 此函数会得到满足给定coherence的角度数组 并将角度数组存放在result_angular.out文件中
%angulars = compute_angular();

load('data_file\result_angular.mat','result_angular');

end

%% 
function antenna_random_space = get_antennaSpace_random(num_antenna,aperture,recompute)
% 此函数会得到随机数组间隔 并将间隔组存放在result_angular.out文件中
if recompute
    antenna_random_space = compute_antennaSpace_random(num_antenna,aperture);
else
    % 从给定文件中的读取数组间隔
    file_name = ['\antennaSpace_random\antenna_',num2str(num_antenna),'_random_space.mat'];

    load(file_name,'antenna_random_space');
end

end

%% 
function [steering_matrix,coherence] = get_steering_matrix(Model_paras,recompute)
if recompute
    [steering_matrix,coherence] = create_steering_matrix(Model_paras);
else
    file_name = '\data_file\steering_matrix';

    load(file_name,'steering_matrix')
    coherence = 10;
end

end
