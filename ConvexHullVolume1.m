function ConvexHullVolume=ConvexHullVolume1(BWMat)
TempIndex=find(BWMat);
[RowIndex, ColIndex, PageIndex]=ind2sub(size(BWMat), TempIndex);

try 
    [ConvexHullRep, ConvexVolume] = convhull(ColIndex, RowIndex, PageIndex);
catch
    ConvexVolume=0; ConvexHullRep = [0,0,0];
end
ConvexHullVolume=ConvexVolume;
end