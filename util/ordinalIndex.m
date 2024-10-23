function [index] = ordinalIndex(subarray)
%ordinalIndex 返回序数模式的模式序号
% @param subarray 子序列
% @return index 序号

% 嵌入维数长度
N=length(subarray);
% 判断这个持久化数组是否存在
persistent ordinalDict;
if isempty(ordinalDict)||length(ordinalDict)~=factorial(N)
    ordinalDict = cell(factorial(N),1);
    % 生成全排列
    perm = perms(N:-1:1);
    % 生成序数模式
    for i=1:length(perm)
        % 将perm(i)的所有元素用_拼接乘字符串
        str = sprintf('%d_',perm(i,:));
        ordinalDict{i} = str;
    end
end
% 将子序列转换成字符串
str = sprintf('%d_',subarray);
% 查找序数模式的序号
index = find(strcmp(ordinalDict,str));
end


