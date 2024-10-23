function [normalizedPe,pe]  = permutationEntropy(data, embeddingDimension, delay)
% PermutationEntropy 计算加权排列熵
% [1] BANDT C, POMPE B. Permutation Entropy: A Natural Complexity Measure for Time Series[J/OL]. Physical Review Letters, 2002, 88(17): 174102. DOI:10.1103/PhysRevLett.88.174102.

% @param data 输入数据                    一维数组
% @param embedding_dimension 嵌入维度     3~10
% @param delay 延迟                      一般为1

% @return normalizedPe 归一化熵
% @return pe 熵


% 检查参数，三个参数缺一不可
if nargin < 3
    error('permutationEntropy: not enough input arguments');
end


N = length(data);

num_patterns = factorial(embeddingDimension);



peSum = 0;
peCounts = zeros(1, num_patterns);


for i = 1:1:N-(embeddingDimension-1)*delay
    pattern = data(i:delay:i+(embeddingDimension-1)*delay);
    [~, pattern_index] = sort(pattern);
    pattern_decimal = ordinalIndex(pattern_index);
    % 排列熵
    peWeight = 1;
    peSum = peSum + peWeight;
    peCounts(pattern_decimal) = peCounts(pattern_decimal)+peWeight; 
end
% 除以总数，得到概率
peProb = peCounts / peSum;
% 计算熵
[normalizedPe,pe] = shannonEntropy(peProb);
end
