%% ������ز���
num_experiment = 500;
maxNum_source = 35;
SNR = 10; % ��λdB

num_antenna = [31 41 51];
%num_antenna = [21 num_antenna];
is_random = 0; % Ϊ0ʱ���߼��Ϊ1/2������Ϊ1ʱ���߼��������� 
add_noise = 0; % Ϊ0ʱ�����������Ϊ1ʱ�������


%% ����ʵ��

success_count = zeros(length(num_antenna),maxNum_source);
parfor m = 1:length(num_antenna)
    % �˴�������Ϊ������steering_matrix ��������Ӧ���ļ���
    steering_matrix = RandomArray_simulation(num_antenna(m),4,is_random,1);
    
    for num_source = 1:maxNum_source
        for k = 1:num_experiment

            source_index = zeros(1,num_source);
            amplitude = complex(zeros(1,num_source));
            size_sourceIndex = 0;

            %���ѡ��һ��������source�����Ӧ�ķ���
            while size_sourceIndex < num_source
                tmp_source_index = round(rand * (size(steering_matrix,2)-1)) + 1;

                if isempty(find(source_index == tmp_source_index))

                    size_sourceIndex = size_sourceIndex + 1;
                    source_index(size_sourceIndex) = tmp_source_index;

                    %���ɶ�Ӧ�ķ���
                    amplitude(size_sourceIndex) = complex(rand * 10 +1,rand * 10 +1);
                end

            end

            %����ģ���ź�
            signal = steering_matrix(:,source_index) * amplitude';

             %�������
            if add_noise == 1
                signal = awgn(signal,SNR,'measured'); 
            end
%             
%             %�������
%             noise = my_wgn(SNR,1,num_antenna(m),1);
%             signal = signal + noise;
            
            
            % ʹ��OMP�㷨��������ź�
            result = OMP(steering_matrix,signal,num_source);
            if length(intersect(source_index,result)) == length(result)
                success_count(m,num_source) = success_count(m,num_source) + 1;
            end
        end
    end
end

%% ���ͼ��
mark = {'c-.s','r-+','g--o','b*:','m-p','y--h'};
success_count = success_count./num_experiment;

figure;
hold on;
for k = 1:size(success_count,1)
    %����legend
    if is_random == 0
        sign = ['uniform ',num2str(num_antenna(k)),' antennas, ',num2str((num_antenna(k) - 1) * 0.05),'m aperture'];
    else
        sign = ['random ',num2str(num_antenna(k)),' antennas, ','4','m aperture'];
    end
    %���ͼ��
    plot(1:maxNum_source,success_count(k,:),mark{k + 1 - is_random},'DisplayName',sign,'LineWidth',1);
end
legend();
xlabel('Number of sources');
ylabel('Probability of perfect estimation');
hold off;
