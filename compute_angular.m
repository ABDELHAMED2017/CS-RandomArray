function result_angular = compute_angular()

min_angular = 0; % 角度的最小值
max_angular = 180; % 角度的最大值
min_angular_space = 1.26; % 相邻角度之间间隔的最小值
coherence = 0.15; % 相关性的最大值
num_antenna = 81; % 天线的个数
num_angular = 91; % 角度的个数 一般置为奇数
middle_angular = 90; % 将角度数组的中间值设为90度
middle_angular_index = floor(num_angular/2)+1; % 计算数组的中间位置索引
result_angular = zeros(1,num_angular);
result_angular(middle_angular_index) = middle_angular;
iterate_left = middle_angular_index-1;
iterate_right = middle_angular_index+1;

% 初始化steering-matrix
dictionary = complex(zeros(num_antenna,num_angular));

%构造对应于第一个角度的steering-vector
for m = 1:num_antenna
    dictionary(m,middle_angular_index) = exp(1i * pi * (m-1) * cos(middle_angular * pi / 180))/sqrt(num_antenna);
end

% 从middle_angular开始往角度增大的方向求出其余的角度
while iterate_right <= num_angular
    angular_now = result_angular(iterate_right-1) + min_angular_space;
    for t = angular_now :0.01:max_angular
        % 获得此角度对应的atom
        for m = 1:num_antenna
            dictionary(m,iterate_right) = exp(1i * pi * (m-1) * cos(t * pi / 180))/sqrt(num_antenna);
        end
        mark = 1;
        
        % 获得已获得dictionary的coherence
        for n = middle_angular_index:iterate_right-1
            inner_product = abs(dictionary(:,n)' * dictionary(:,iterate_right));
            if inner_product > coherence
                mark = 0;
                break;
            end
        end
        
        if mark == 1
            result_angular(iterate_right) = t;
            iterate_right = iterate_right + 1;
            break;
        end
    end
end

% 从middle_angular开始往角度减小的方向求出其余的角度
while iterate_left > 0
    angular_now = result_angular(iterate_left + 1) - min_angular_space;
    for t = angular_now :-0.01:0
        % 获得此角度对应的atom
        for m = 1:num_antenna
            dictionary(m,iterate_left) = exp(1i * pi * (m-1) * cos(t * pi / 180))/sqrt(num_antenna);
        end
        mark = 1;
        
        % 获得已获得dictionary的coherence
        for n = iterate_left+1:num_angular
            inner_product = abs(dictionary(:,n)' * dictionary(:,iterate_left));
            if inner_product > coherence
                mark = 0;
                break;
            end
        end
        
        if mark == 1
            result_angular(iterate_left) = t;
            iterate_left = iterate_left - 1;
            break;
        end
    end
end

plot(result_angular(1,2:end),result_angular(1,2:end)-result_angular(1,1:end-1),'m-p');
xlabel('Angle');  %x轴坐标描述
ylabel('Width of each angle bin'); %y轴坐标描述

% 将计算结果保存到文件
file_name = 'D:\MATLAB\workplace\CS_RandomArray\data_file\result_angular.mat';
save(file_name,'result_angular');


end