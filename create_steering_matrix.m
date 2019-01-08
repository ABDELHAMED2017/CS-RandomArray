function [steering_matrix,coherence] = create_steering_matrix(Model_paras)

    steering_matrix = complex(zeros(Model_paras.num_antenna,length(Model_paras.angulars)));
    

    for t = 1:length(Model_paras.angulars)
        angular = Model_paras.angulars(t);
        for  m = 1:Model_paras.num_antenna
            steering_matrix(m,t) = exp(1i * 2*pi * Model_paras.antenna_space(m) * cos(angular * pi / 180) * Model_paras.work_frequency / Model_paras.speed_light);
        end
    end
    %Normalization
    steering_matrix = steering_matrix/sqrt(Model_paras.num_antenna);

    coherence = complex(0);
    
    %计算coherence
    for t = 1:length(Model_paras.angulars)
        for k = t+1:length(Model_paras.angulars)
            inner_product = abs(steering_matrix(:,t)' * steering_matrix(:,k));
            if inner_product > coherence
                coherence = inner_product;
            end
        end
    end
    
% 将计算结果保存到文件
file_name = '\data_file\steering_matrix.mat';

save(file_name,'steering_matrix') ;
    
    
    
%     coherence = complex(0);
%     
%     %计算coherence
%     coherence_all = abs(dictionary' * dictionary);
%     for t = 1:Model_paras.angular_num
%         for  m = t+1:Model_paras.angular_num
%             if coherence < coherence_all(m,t)
%                 coherence = coherence_all(m,t);
%             end
%         end
%     end
%     coherence
end