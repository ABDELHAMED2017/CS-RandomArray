function antenna_random_space = compute_antennaSpace_random(num_antenna,aperture)
    
num_unit = 0;
antenna_random_space = zeros(1,num_antenna-1);
for t = 1:length(antenna_random_space)
    antenna_random_space(t) = round(rand*10) + 1;
    if t ~= 1 
        antenna_random_space(t) = antenna_random_space(t) + antenna_random_space(t-1);
    end
    num_unit = antenna_random_space(t);
end

for t = 1:length(antenna_random_space)
    antenna_random_space(t) = aperture * antenna_random_space(t) / num_unit;
end

% 将计算结果保存到文件
file_name = ['D:\MATLAB\workplace\CS_RandomArray\antennaSpace_random\antenna_' num2str(num_antenna) '_random_space.mat'];

save(file_name,'antenna_random_space');

end