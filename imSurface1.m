function [surf] = imSurface1(mask)
perimeter = bwperim(mask,26);
surf = length(find(perimeter));