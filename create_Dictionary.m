function [dictionary,coherence] = create_Dictionary(Model_paras)

    dictionary = complex(zeros(Model_paras.num_antenna,length(Model_paras.angulars)));
    

    for t = 1:length(Model_paras.angulars)
        angular = Model_paras.angulars(t);
        for  m = 1:Model_paras.num_antenna
            dictionary(m,t) = exp(1i * 2*pi * Model_paras.antenna_space(m) * cos(angular * pi / 180) * Model_paras.work_frequency / Model_paras.speed_light);
        end
    end
    %Normalization
    dictionary = dictionary/sqrt(Model_paras.num_antenna);

    coherence = complex(0);
    
    %计算coherence
    for t = 1:length(Model_paras.angulars)
        for k = t+1:length(Model_paras.angulars)
            inner_product = abs(dictionary(:,t)' * dictionary(:,k));
            if inner_product > coherence
                coherence = inner_product;
            end
        end
    end
% 将计算结果保存到文件
file_name = 'D:\MATLAB\workplace\CS_RandomArray\data_file\dictionary';

save(file_name,'dictionary') ;
    
    
    
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