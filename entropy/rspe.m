function [normalizedRspe,rspe]  = RSPE(data, embeddingDimension, delay)
% RSPE Rescaled range permutation entropy
% [1] REN W, ZHANG J, JIN N. Rescaled range permutation entropy: a method for quantifying the dynamical complexity of gas–liquid two-phase slug flow[J/OL]. Nonlinear Dynamics, 2021, 104(4): 4035-4043. DOI:10.1007/s11071-021-06468-2.

% @param data 输入数据                    一维数组
% @param embedding_dimension 嵌入维度     3~10
% @param delay 延迟                      一般为1

% @return normalized_entropy 归一化熵
% @return entropy 熵


% 检查参数，三个参数缺一不可
if nargin < 3
    error('permutationEntropy: not enough input arguments');
end


N = length(data);
num_patterns = factorial(embeddingDimension);

% 总权重存储
rspeSum = 0;
rspeCounts = zeros(1, num_patterns);


for i = 1:1:N-(embeddingDimension-1)*delay
    pattern = data(i:delay:i+(embeddingDimension-1)*delay);
    [~, pattern_index] = sort(pattern);
    pattern_decimal = ordinalIndex(pattern_index);
    % RSPE
    rspeWeight = range(pattern)/std(pattern);
    if isnan(rspeWeight)
        rspeWeight = 0;
    end
    rspeSum = rspeSum + rspeWeight;
    rspeCounts(pattern_decimal) = rspeCounts(pattern_decimal)+rspeWeight; 
end
% 除以总数，得到概率
rspeProb = rspeCounts / rspeSum;
% 计算熵
[normalizedRspe,rspe] = shannonEntropy(rspeProb);
end