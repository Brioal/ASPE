function [normalizedWpe,wpe]  = wpe(data, embeddingDimension, delay)
% WPE Weighted-permutation entropy
% [1] FADLALLAH B, CHEN B, KEIL A, et al. Weighted-permutation entropy: A complexity measure for time series incorporating amplitude information[J/OL]. Physical Review E, 2013, 87(2): 022911. DOI:10.1103/PhysRevE.87.022911.

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

% WPE
wpeSum = 0;
wpeCounts = zeros(1, num_patterns);


for i = 1:1:N-(embeddingDimension-1)*delay
    pattern = data(i:delay:i+(embeddingDimension-1)*delay);
    [~, pattern_index] = sort(pattern);
    pattern_decimal = ordinalIndex(pattern_index);
    % 加权排列熵
    wpeWeight = var(pattern);
    if isnan(wpeWeight)
        wpeWeight = 0;
    end
    wpeSum = wpeSum + wpeWeight;
    wpeCounts(pattern_decimal) = wpeCounts(pattern_decimal)+wpeWeight; 
end
% 除以总数，得到概率
wpeProb = wpeCounts / wpeSum;
% 计算熵
[normalizedWpe,wpe] = shannonEntropy(wpeProb);
end
