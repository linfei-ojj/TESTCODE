function [solidity] =Solidity1(mask)
% SOLIDITY COMPUTATION
perimeter = bwperim(mask,26);
nPoints = length(find(perimeter));
X = zeros(nPoints,1); Y = zeros(nPoints,1); Z = zeros(nPoints,1);
count = 1;
for i = 1:size(perimeter,3)
    [row,col] = find(perimeter(:,:,i));
    p = length(row);
    if p > 0
        X(count:count+p-1,1) = col(1:end);
        Y(count:count+p-1,1) = row(1:end);
        Z(count:count+p-1,1) = i;
        count = count + p;
    end
end
[~,volumeH] = convhull(X,Y,Z);
volumeROI = sum(mask(:));
solidity = volumeROI/volumeH;


