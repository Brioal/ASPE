function [normalizedEntropy,entropy] = shannonEntropy(probabilities)
%shannonEntropy 计算概率分布的香农熵
% @param probabilities 概率分布 大小：1 * N
% @return entropy 香农熵
% @return normalizedEntropy 归一化香农熵

% Calculate the Shannon entropy
noZeroprobabilities = probabilities(probabilities ~= 0);
entropy = -sum(noZeroprobabilities .* log2(noZeroprobabilities));

% Calculate the normalized Shannon entropy
normalizedEntropy = entropy / log2(length(probabilities));
end
