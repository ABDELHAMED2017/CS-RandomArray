function result = OMP(dictionary,signal,sparse_level)

if size(signal,1) == 1 
    signal = signal.';
end

result = zeros(1,sparse_level);
dic_mark = zeros(1,size(dictionary,2));
size_result = 0;

residual_signal = signal;

while size_result ~= sparse_level
    index = 1;
    inner_residANDdic = dictionary(:,index)' * residual_signal;
    for k = 2:size(dictionary,2)
        inner_tmp = abs(dictionary(:,k)' * residual_signal);
        if inner_tmp > inner_residANDdic
            inner_residANDdic = inner_tmp;
            index = k;
        end
    end
    if dic_mark(index) ~=1
        size_result = size_result + 1;
        result(size_result) = index;
    end
    A = dictionary(:,result(1,1:size_result));
    approxi_signal = A*((A'*A)^-1 * A' * signal);
    residual_signal = signal - approxi_signal;
end

end
