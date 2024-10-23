function [aspe]  = aspe(data, embeddingDimension, delay)
% aspe Amplitude-Sensitive Permutation Entropy

% @param data 输入数据                    
% @param embedding_dimension 嵌入维度     
% @param delay 延迟                      

% @return aspe ASPE

% 检查参数，三个参数缺一不可
if nargin < 3
    error('aspe: not enough input arguments');
end

N = length(data);
% 格式化0~1
data=normalize(data, 'range', [0, 1]);
num_patterns = factorial(embeddingDimension);
% 总权重存储

aspeSum = 0;
aspeCounts = zeros(1, num_patterns);

for i = 1:1:N-(embeddingDimension-1)*delay
    pattern = data(i:delay:i+(embeddingDimension-1)*delay);
    [~, pattern_index] = sort(pattern);
    pattern_decimal = ordinalIndex(pattern_index);
    
    % 3 标准差/均值
    cvWeight = std(pattern)/mean(pattern);
    if isnan(cvWeight)
        cvWeight = 0;
    end
    aspeSum = aspeSum + cvWeight;
    aspeCounts(pattern_decimal) = aspeCounts(pattern_decimal)+cvWeight;

end
% 除以总数，得到概率
aspeProb = aspeCounts / aspeSum;
% 计算熵
[aspe,~] = shannonEntropy(aspeProb);
end
