function result_angular = compute_angular()

min_angular = 0; % �Ƕȵ���Сֵ
max_angular = 180; % �Ƕȵ����ֵ
min_angular_space = 1.26; % ���ڽǶ�֮��������Сֵ
coherence = 0.15; % ����Ե����ֵ
num_antenna = 81; % ���ߵĸ���
num_angular = 91; % �Ƕȵĸ��� һ����Ϊ����
middle_angular = 90; % ���Ƕ�������м�ֵ��Ϊ90��
middle_angular_index = floor(num_angular/2)+1; % ����������м�λ������
result_angular = zeros(1,num_angular);
result_angular(middle_angular_index) = middle_angular;
iterate_left = middle_angular_index-1;
iterate_right = middle_angular_index+1;

% ��ʼ��steering-matrix
dictionary = complex(zeros(num_antenna,num_angular));

%�����Ӧ�ڵ�һ���Ƕȵ�steering-vector
for m = 1:num_antenna
    dictionary(m,middle_angular_index) = exp(1i * pi * (m-1) * cos(middle_angular * pi / 180))/sqrt(num_antenna);
end

% ��middle_angular��ʼ���Ƕ�����ķ����������ĽǶ�
while iterate_right <= num_angular
    angular_now = result_angular(iterate_right-1) + min_angular_space;
    for t = angular_now :0.01:max_angular
        % ��ô˽Ƕȶ�Ӧ��atom
        for m = 1:num_antenna
            dictionary(m,iterate_right) = exp(1i * pi * (m-1) * cos(t * pi / 180))/sqrt(num_antenna);
        end
        mark = 1;
        
        % ����ѻ��dictionary��coherence
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

% ��middle_angular��ʼ���Ƕȼ�С�ķ����������ĽǶ�
while iterate_left > 0
    angular_now = result_angular(iterate_left + 1) - min_angular_space;
    for t = angular_now :-0.01:0
        % ��ô˽Ƕȶ�Ӧ��atom
        for m = 1:num_antenna
            dictionary(m,iterate_left) = exp(1i * pi * (m-1) * cos(t * pi / 180))/sqrt(num_antenna);
        end
        mark = 1;
        
        % ����ѻ��dictionary��coherence
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
xlabel('Angle');  %x����������
ylabel('Width of each angle bin'); %y����������

% �����������浽�ļ�
file_name = 'D:\MATLAB\workplace\CS_RandomArray\data_file\result_angular.mat';
save(file_name,'result_angular');


end